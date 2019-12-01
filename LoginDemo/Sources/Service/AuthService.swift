import KeychainAccess

class AuthService {
    
    private let kUsersKey = "Users"
    
    private(set) var currentUser: User? {
        get {
            return self.storage.currentUser
        }
        set {
            self.storage.currentUser = newValue
        }
    }
    
    var aurorized: Bool { return self.currentUser != nil }

    private let storage: Storage
    
    //заменить на аус дата для реалма
    
    init(storage: Storage) {
        self.storage = storage
    }

    func isAuthorized(user: String, with password: String) -> Bool {
        guard let user = self.storage.user(with: user), user.password == password else {
            return false
        }
        
        self.currentUser = user
        return true
    }
    
    func unauthorize() {
        self.currentUser = nil
    }
    
    func register(name: String,
                  password: String,
                  birthDate: Date,
                  gender: Gender
                  ) -> Bool {
        
        let user1 = User(password: password, name: name, birthDate: birthDate , gender: gender)
        
        var users = self.storage.loadUsers()
        users.append(user1)
        self.storage.save(users: users)

        self.currentUser = user1
        return true
    }
    
}

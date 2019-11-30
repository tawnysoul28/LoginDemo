import KeychainAccess

class AuthService {
    
    private let kUsersKey = "Users"
    private let kCurrentUserKey = "currentUser"
    
    private(set) var currentUser: String? {
        get {
            return self.storage.string(forKey: self.kCurrentUserKey)
        }
        set {
            self.storage.set(newValue, forKey: self.kCurrentUserKey)
        }
    }
    
    var aurorized: Bool { return self.currentUser != nil }

    private let storage: UserDefaults
    private let keychain: Keychain
    
    //заменить на аус дата для реалма
    
    init(storage: UserDefaults) {
        self.storage = storage
        
        self.keychain = Keychain(service: "com.bob.logindemo")
            .accessibility(.afterFirstUnlock)
            .synchronizable(true)
    }

    func isAuthorized(user: String, with password: String) -> Bool {
        guard let users = self.storage.dictionary(forKey: self.kUsersKey) else { return false }
        guard let password = users[user] as? String, password == password else { return false }
        
        self.currentUser = user
        return true
    }
    
    func unauthorize() {
        self.currentUser = nil
    }
    
    func register(user: String?, password: String?) -> Bool {
        guard let user = user, let password = password else { return false }
        guard !user.isEmpty && !password.isEmpty else { return false }
        
        var users = self.storage.dictionary(forKey: self.kUsersKey) ?? [:]
        users[user] = password
        storage.set(users, forKey: self.kUsersKey)
        
        self.currentUser = user
        return true
    }
    
}

import Foundation
import KeychainAccess

final class Storage {
    private enum Keys: String {
        case currentUser
        case users = "Users"
    }
    
    private var cachedUsers: [User]? = nil
    private var cachedCurrentUser: User? = nil
    
    private let keychain: Keychain
    
    init() {
        
        self.keychain = Keychain(service: "com.bob.logindemo")
            .accessibility(.afterFirstUnlock)
    }
    
    //Хранение всех юзеров в массиве [User], который также сериализируется/десериализируется в Keychain
    func save(users: [User]) {
        self.cachedUsers = users
        guard let data = try? JSONEncoder().encode(users) else {
            return
        }
        
        try? self.keychain.set(data, key: Keys.users.rawValue)
    }
    
    //Когда достаю из Keychain, просто ищу нужного user.
    func loadUsers() -> [User] {
        if let cachedUsers = self.cachedUsers { return cachedUsers }

        if let usersData = try? self.keychain.getData(Keys.users.rawValue),
            let users = try? JSONDecoder().decode([User].self, from: usersData) {
            self.cachedUsers = users
            return users
        }
        return []
    }
    
    func user(with name: String) -> User? {
        return self.loadUsers().first(where: { $0.name == name })
    }
    
    var currentUser: User? {
        get {
            if let cachedUser = self.cachedCurrentUser { return cachedUser }

            guard let data = try? self.keychain.getData(Keys.currentUser.rawValue),
                let user = try? JSONDecoder().decode(User.self, from: data) else {
                return nil
            }
            self.cachedCurrentUser = user
            return user
        }
        set {
            self.cachedCurrentUser = newValue
            self.update(newValue)
            
            if let data = try? JSONEncoder().encode(newValue) {
                try? self.keychain.set(data, key: Keys.currentUser.rawValue)
            } else {
                try? self.keychain.remove(Keys.currentUser.rawValue)
            }
        }
    }
    
    private func update(_ user: User?) {
        guard let user = user else { return }

        var users = self.loadUsers()
        users.removeAll { $0.name == user.name }
        users.append(user)
        self.save(users: users)
    }
}

//Cохраняnm не в userDefaults, а в кейчейн словарь с юзерами:
//self.keychain.setString(users.jsonString, key: «Users»)


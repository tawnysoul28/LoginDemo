import Foundation
import KeychainAccess

class Storage {

    private let keychain: Keychain
    private enum Keys: String {
        case currentUser
    }
    
    init() {
        
        self.keychain = Keychain(service: "com.bob.logindemo")
            .accessibility(.afterFirstUnlock)
    }
    
    //Хранение всех юзеров в массиве [User], который также сериализируется/десериализируется в Keychain
    func save(users: [User]) {
        guard let data = try? JSONEncoder().encode(users) else {
            return
        }
        
        try? self.keychain.set(data, key: "Users")
    }
    
    //Когда достаю из Keychain, просто ищу нужного user.
    func loadUsers() -> [User] {
        if let usersData = try? self.keychain.getData("Users"),
            let users = try? JSONDecoder().decode([User].self, from: usersData) {
            return users
        }
        return []
    }
    
    func user(with name: String) -> User? {
        return self.loadUsers().first(where: { $0.name == name })
    }
    
    var currentUser: User? {
        get {
            guard let data = try? self.keychain.getData(Keys.currentUser.rawValue),
                let user = try? JSONDecoder().decode(User.self, from: data) else {
                return nil
            }
            return user
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                try? self.keychain.set(data, key: Keys.currentUser.rawValue)
            } else {
                try? self.keychain.remove(Keys.currentUser.rawValue)
            }
        }
    }
}

//Cохраняnm не в userDefaults, а в кейчейн словарь с юзерами:
//self.keychain.setString(users.jsonString, key: «Users»)


import KeychainAccess

extension Keychain {

    func set(dictionary: [String : String], for key: String) {
        do {
            try self.set(dictionary.jsonString, key: key)
        } catch {
            
        }
    }
    
    func get(dictionary: [String : String], for key: String) -> [String : String] {
        do {
            let string = try self.getString(key)
            return string?.dictionary ?? [:]
        } catch {
            
        }
        return [:]
    }
    
}

extension Dictionary {
    
    var jsonString: String {
        do {
            let stringData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            if let string = String(data: stringData, encoding: .utf8) {
                return string
            }
        }catch _ {
            
        }
        return ""
    }

}

extension String {
    //JSONstring to dictionatry
    var dictionary: [String : String] {
        let defaultResult = [String: String]()
        guard let data = self.data(using: .utf8) else {
            return defaultResult
        }
        
        guard let object = try? JSONSerialization.jsonObject(with: data, options: []) else {
            return defaultResult
        }
        
        guard let result = object as? [String: String] else {
            return defaultResult
        }
        
        return result
    }
}

import Foundation

struct User: Codable {
    let password: String
    let name: String
    let birthDate: Date
    let gender: Gender
    var habit: String
}

enum Gender: String, Codable {
    case male
    case female
}

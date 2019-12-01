//
//  User.swift
//  LoginDemo
//
//  Created by Bob on 30/11/2019.
//  Copyright © 2019 Bob. All rights reserved.
//

import Foundation

struct User: Codable {
    let password: String
    let name: String
    let birthDate: Date
    let gender: Gender
}

enum Gender: String, Codable {
    case male
    case female
}

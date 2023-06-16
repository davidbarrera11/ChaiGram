//
//  RegisterRequest.swift
//  ChaiGram
//
//  Created by Chaii on 15/06/23.
//

import Foundation

struct RegisterRequest: Codable {
    let username: String
    let email: String
    let password: String
}

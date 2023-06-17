//
//  Endpoints.swift
//  ChaiGram
//
//  Created by Chaii on 16/06/23.
//

import Foundation

enum Endpoints {
    case register
    case login
    case getUser(user: String)
    
    private var baseUrl: String { "http://192.168.0.25:3000" }
    
    var url: String {
        
        switch self {
        case .register:
            return "\(baseUrl)/registro"
        case .login:
            return "\(baseUrl)/autenticacion"
        case .getUser(let user):
            return "\(baseUrl)/profile/\(user)"

        }
    }
}

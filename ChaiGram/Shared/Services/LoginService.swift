//
//  LoginService.swift
//  ChaiGram
//
//  Created by Chaii on 19/06/23.
//

import Foundation

protocol LoginServiceProtocol {
    func login(request: RegisterRequest, callback: @escaping (Result<LoginResponse, ServiceError>) -> Void)
    func recoverPassword(email: String)
}

final class LoginService: LoginServiceProtocol {
    
    func login(request data: RegisterRequest, callback: @escaping (Result<LoginResponse, ServiceError>) -> Void) {
        
        API.execute(
            url: Endpoints.login.url,
            method: .post,
            headers: [.contentType: .applicationJson],
            data: data
        ) { result in
            switch result {
            case .success(let data):
                do {
                    //Serializar resultado a lo que necesito
                    let serializeData = try JSONDecoder().decode(LoginResponse.self, from: data)
                    DispatchQueue.main.async {
                        callback(.success(serializeData))
                    }
                    
                    // no serializa la data
                } catch {
                    callback(.failure(.invalidResponse))
                    print(error)
                }
            case .failure(let failure):
                callback(.failure(failure))
            }
        }
    }
    
    func recoverPassword(email: String) {
        
    }
    
}

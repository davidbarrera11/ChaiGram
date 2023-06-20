//
//  RegisterService.swift
//  ChaiGram
//
//  Created by Chaii on 19/06/23.
//

import Foundation

protocol RegisterServiceProtocol {
    func postUser(request: RegisterRequest, callback: @escaping (Result<RegisterResponse, ServiceError>) -> Void)
}

final class RegisterService: RegisterServiceProtocol {
    
    func postUser(request data: RegisterRequest, callback: @escaping (Result<RegisterResponse, ServiceError>) -> Void) {
        
        API.execute(
            url: Endpoints.register.url,
            method: .post,
            headers: [.contentType: .applicationJson],
            data: data
        ) { result in
            switch result {
            case .success(let data):
                do {
                    //Serializar resultado a lo que necesito
                    let serializeData = try JSONDecoder().decode(RegisterResponse.self, from: data)
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
}


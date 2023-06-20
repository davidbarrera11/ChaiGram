//
//  HomeService.swift
//  ChaiGram
//
//  Created by Chaii on 19/06/23.
//

import Foundation

protocol HomeServiceProtocol {
    func getUserInfo(userName: String, callback: @escaping (Result<UserProfile, ServiceError>) -> Void)
}

enum ServiceError: Error {
    case serverError
    case invalidCode
    case invalidData
    case invalidResponse
}

final class HomeService: HomeServiceProtocol {
    func getUserInfo(userName: String, callback: @escaping (Result<UserProfile, ServiceError>) -> Void) {
        API.execute(
            url: Endpoints.getUser(user: userName).url,
            method: .get,
            headers: [.contentType:.applicationJson],
            data: nil) {
                userInfo in
                switch(userInfo) {
                case.success(let data):
                    do {
                        let serializeData = try JSONDecoder().decode(UserProfile.self, from: data)
                        DispatchQueue.main.async{
                            callback(.success(serializeData))
                        }
                        
                    } catch {
                        print(error)
                    }
                    break
                case.failure(let failure):
                    callback(.failure(failure))
                }
            }
    }
    
}

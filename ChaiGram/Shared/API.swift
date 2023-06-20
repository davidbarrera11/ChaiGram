//
//  API.swift
//  ChaiGram
//
//  Created by Chaii on 19/06/23.
//

import Foundation

final class API {
    enum Method: String {
        case get
        case post
        case put
        
        var value: String {
            return rawValue.uppercased()
        }
    }
    
    enum Headers {
        enum Key: String {
            case contentType = "Content-Type"
        }
        
        enum Value: String {
            case applicationJson = "application/json"
        }
    }
    
    static func execute(
        url: String,
        method: Method,
        headers: [Headers.Key: Headers.Value],
        data: Codable?,
        callback: @escaping (Result<Data, ServiceError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        // preparar servicio y data
        request.httpMethod = method.value
        
        if let data {
            request.httpBody = try? JSONEncoder().encode(data)
        }
        
        headers.forEach {
            request.setValue($0.value.rawValue, forHTTPHeaderField: $0.key.rawValue)
        }
        
        // preparar peticion
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, urlResponse: URLResponse?, error: Error?) in
            //Validar parametros post ejecucion
            guard error == nil else {
                DispatchQueue.main.async {
                    callback(.failure(.serverError))
                }
                return
            }
            
            guard let statusCode = (urlResponse as? HTTPURLResponse)?.statusCode else {
                DispatchQueue.main.async {
                    callback(.failure(.invalidCode))
                }
                return
            }
            
            guard (200...299).contains(statusCode) else {
                DispatchQueue.main.async {
                    callback(.failure(.invalidCode))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    callback(.failure(.invalidData))
                }
                return
            }
        
        
            callback(.success(data))
        }
        
        // Ejecutar su peticion
        task.resume()
    }
}

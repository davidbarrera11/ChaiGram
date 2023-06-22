//
//  Utils.swift
//  ChaiGram
//
//  Created by Chaii on 19/06/23.
//

import Foundation
final class Utils {
    static func errorMessages(error: ServiceError) -> String {
        let message: String
        switch error {
        case .invalidCode:
            message = "Codigo invalido"
            break
        case .serverError:
            message = "Error con el servidor"
            break
        case .invalidData:
            message = "Problema con los datos enviados"
            break
        case .invalidResponse:
            message = "Problema con la respuesta del servidor"
            break
        }
        return message
    }
}

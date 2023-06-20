//
//  Utils.swift
//  ChaiGram
//
//  Created by Chaii on 19/06/23.
//

import Foundation

final class Utils {
    static func errorMessages(error: ServiceError) {
        switch error {
        case .invalidCode:
            print("Codigo invalido")
            break
        case .serverError:
            print("Error con el servidor")
            break
        case .invalidData:
            print("Problema con los datos enviados")
            break
        case .invalidResponse:
            print("Problema con la respuesta del servidor")
            break
        }
    }
}

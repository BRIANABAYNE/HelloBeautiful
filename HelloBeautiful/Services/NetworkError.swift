//
//  NetworkError.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/25/23.
//

import Foundation
enum NetworkingError: LocalizedError {

    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    case invalidStatusCode

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL. Check your endpoint."
        case .thrownError(let error):
            return "Thrown error. Error was \(error.localizedDescription)"
        case .noData:
            return "No data received from successful network fetch."
        case .unableToDecode:
            return "Unable to decode model object from data."
        case .invalidStatusCode:
            return "Fetch returned an unsuccessful status code. Code was not 200."
        }
    }
}

//
//  CreateAccountError.swift
//  HelloBeautiful
//
//  Created by Briana Bayne on 7/27/23.
//

import Foundation
enum CreateAccountError: LocalizedError {
    case firebaseError(Error)
    case passwordMismatch
   
    var errorDescription: String? {
        switch self {
        case .firebaseError(let error):
            return "\(error.localizedDescription)"
        case .passwordMismatch:
            return "Looks like the passwords do not match. Try again"
        }
    }
}

//
//  ErrorHandler.swift
//  TaskManagement
//
//  Created by Tina Thomsen on 24/01/2025.
//

import Foundation

enum DataError: Error, LocalizedError {
    case fileNotFound
    case decodingError
    case userNotFound
    case invalidCredentials
    case userTaskNotFound
}

class ErrorHandler {
    static func handle(error: Error) -> String {
        if let dataError = error as? DataError {
            switch dataError {
            case .fileNotFound:
                return AppStrings.Errors.fileNotFound
            case .decodingError:
                return AppStrings.Errors.decodingError
            case .userNotFound:
                return AppStrings.Errors.invalidUsername
            case .invalidCredentials:
                return AppStrings.Errors.invalidPassword
            case .userTaskNotFound:
                return AppStrings.Errors.invalidTaskId
            }
        }
        return "An unexpected error occurred. Please try again."
    }
}

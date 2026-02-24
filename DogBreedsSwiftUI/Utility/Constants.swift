//
//  Constants.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

// MARK: Server Endpoints

enum ServerEndpoints: String {
    case dogBreedsList = "https://dog.ceo/api/breeds/list/all"
}

// MARK: Error Messages for Log

enum ErrorMessages: String {
    case invalidURL = "Log: Invalid URL"
    case serverError = "Log: Server returned error"
    case codeError = "Log: Error when running network code"
}

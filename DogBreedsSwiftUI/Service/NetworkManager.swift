//
//  NetworkManager.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI
import Alamofire

class NetworkManager: NetworkManagerProtocol {
    /// Singleton for NetworkManager
    static let shared = NetworkManager()
    
    private init() {}
    
    // MARK: Fetch List of All Dog Breeds and Sub-breeds from Server
    
    func fetchAllDogBreeds(url: String?) async -> [DogBreed] {
        guard let uwURL = url else {
            print(ErrorMessages.invalidURL.rawValue)
            return []
        }
        
        let serverResponse = try? await AF.request(uwURL)
            .validate()
            .serializingDecodable(DogBreedServerResponse.self)
            .value
        
        guard let uwServerResponse = serverResponse, let uwMessage = uwServerResponse.message else {
            print(ErrorMessages.codeError.rawValue)
            return []
        }
        
        return uwMessage.map { DogBreed(name: $0.key, subBreeds: $0.value) }
    }
    
    // MARK: Fetch the exact URL for Dog breed's image from Server
    
    func fetchDogImageURL(urlToGetDogImageURL: String?) async -> String {
        guard let uwURL = urlToGetDogImageURL else {
            print(ErrorMessages.invalidURL.rawValue)
            return ""
        }
        
        let serverResponse = try? await AF.request(uwURL)
            .validate()
            .serializingDecodable(DogImageServerResponse.self)
            .value
        
        guard let uwServerResponse = serverResponse, let uwMessage = uwServerResponse.message else {
            print(ErrorMessages.codeError)
            return ""
        }
        
        return uwMessage
    }
}

//
//  NetworkManager.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

protocol NetworkManagerProtocol {
    func fetchAllDogBreeds(url: String?) async -> [DogBreed]
    func fetchDogImageURL(urlToGetDogImageURL: String?) async -> String
}

class NetworkManager: NetworkManagerProtocol {
    /// Singleton for NetworkManager
    static let shared = NetworkManager()
    
    init() {}
    
    // MARK: Fetch List of All Dog Breeds and Sub-breeds from Server
    
    func fetchAllDogBreeds(url: String?) async -> [DogBreed] {
        guard let uwURL = url, let serverURL = URL(string: uwURL) else {
            print(ErrorMessages.invalidURL.rawValue)
            return []
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print(ErrorMessages.serverError.rawValue)
                return []
            }
            let dogBreedsResponse = try? JSONDecoder().decode(DogBreedServerResponse.self, from: data)
            var dogBreedsList: [DogBreed] = []
            
            guard let uwDogBreedsResponse = dogBreedsResponse, let uwMessage = uwDogBreedsResponse.message else {
                return []
            }
            
            for (breed, subBreeds) in uwMessage {
                dogBreedsList.append(
                    DogBreed(name: breed, subBreeds: subBreeds)
                )
            }
            
            return dogBreedsList
        } catch {
            print(ErrorMessages.codeError.rawValue)
            return []
        }
    }
    
    // MARK: Fetch the exact URL for Dog breed's image from Server
    
    func fetchDogImageURL(urlToGetDogImageURL: String?) async -> String {
        guard let uwURL = urlToGetDogImageURL, let serverURL = URL(string: uwURL) else {
            print(ErrorMessages.invalidURL.rawValue)
            return ""
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: serverURL)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print(ErrorMessages.serverError.rawValue)
                return ""
            }
            let dogImageResponse = try? JSONDecoder().decode(DogImageServerResponse.self, from: data)
            
            return dogImageResponse?.message ?? ""
        } catch {
            print(ErrorMessages.codeError.rawValue)
            return ""
        }
    }
}

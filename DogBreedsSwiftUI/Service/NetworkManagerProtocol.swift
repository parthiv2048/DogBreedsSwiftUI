//
//  NetworkManagerProtocol.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 3/13/26.
//

protocol NetworkManagerProtocol {
    func fetchAllDogBreeds(url: String?) async -> [DogBreed]
    func fetchDogImageURL(urlToGetDogImageURL: String?) async -> String
}

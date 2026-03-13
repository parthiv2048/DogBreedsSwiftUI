//
//  DogBreedsModel.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import Foundation

nonisolated struct DogBreed: Identifiable {
    let id = UUID()
    var name: String?
    var subBreeds: [String]?
}

nonisolated struct DogBreedServerResponse: Decodable {
    let message: [String: [String]]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
}

nonisolated struct DogImageServerResponse: Decodable {
    let message: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case status
    }
}

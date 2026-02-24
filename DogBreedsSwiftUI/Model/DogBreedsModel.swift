//
//  DogBreedsModel.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

struct DogBreed {
    var name: String?
    var subBreeds: [String]?
}

struct DogBreedServerResponse: Decodable {
    let message: [String: [String]]?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
}

struct DogImageServerResponse: Decodable {
    let message: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case message, status
    }
}

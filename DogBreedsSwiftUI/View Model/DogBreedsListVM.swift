//
//  DogBreedsListVM.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import Foundation

protocol DogBreedsListVMProtocol {
    func downloadDogBreeds() async
    func getDogBreedsList() -> [DogBreed]?
}

@Observable
class DogBreedsListVM: DogBreedsListVMProtocol {
    
    // MARK: - Properties
    
    private var dogBreedsList: [DogBreed]?
    private var networkManager: NetworkManagerProtocol?
    
    // MARK: - Initializer (Injection)
    
    init(dogBreedsList: [DogBreed]? = nil, networkManager: NetworkManagerProtocol? = nil) {
        self.dogBreedsList = dogBreedsList
        self.networkManager = networkManager
    }
    
    // MARK: - Helper Methods
    
    func downloadDogBreeds() async {
        dogBreedsList = await self.networkManager?.fetchAllDogBreeds(url: ServerEndpoints.dogBreedsList.rawValue)
    }
    
    func getDogBreedsList() -> [DogBreed]? {
        return dogBreedsList
    }
}

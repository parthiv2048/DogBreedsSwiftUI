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
    private var dogBreedsList: [DogBreed]?
    private var networkManager: NetworkManagerProtocol?
    
    init(dogBreedsList: [DogBreed]? = nil, networkManager: NetworkManagerProtocol? = nil) {
        self.dogBreedsList = dogBreedsList
        self.networkManager = networkManager
    }
    
    func downloadDogBreeds() async {
        dogBreedsList = await self.networkManager?.fetchAllDogBreeds(url: ServerEndpoints.dogBreedsList.rawValue)
    }
    
    func getDogBreedsList() -> [DogBreed]? {
        return dogBreedsList
    }
}

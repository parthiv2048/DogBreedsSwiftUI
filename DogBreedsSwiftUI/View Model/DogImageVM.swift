//
//  DogImageVM.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

protocol DogImageVMProtocol {
    func downloadDogImageURL() async
    func getDogImageURL() -> String?
}

@Observable
class DogImageVM: DogImageVMProtocol {
    private var networkManager: NetworkManagerProtocol?
    private var urlToGetDogImageURL: String?
    private var dogImageURL: String?
    
    init(urlToGetDogImageURL: String? = nil, networkManager: NetworkManagerProtocol? = nil) {
        self.urlToGetDogImageURL = urlToGetDogImageURL
        self.networkManager = networkManager
    }
    
    func downloadDogImageURL() async {
        dogImageURL = await self.networkManager?.fetchDogImageURL(urlToGetDogImageURL: urlToGetDogImageURL)
    }
    
    func getDogImageURL() -> String? {
        print(dogImageURL ?? "No image")
        return dogImageURL
    }
}

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
    func getDogName() -> String?
}

@Observable
class DogImageVM: DogImageVMProtocol {
    private var networkManager: NetworkManagerProtocol?
    private var urlToGetDogImageURL: String?
    private var dogImageURL: String?
    private var dogName: String?
    
    init(urlToGetDogImageURL: String? = nil, networkManager: NetworkManagerProtocol? = nil, dogName: String? = nil) {
        self.urlToGetDogImageURL = urlToGetDogImageURL
        self.networkManager = networkManager
        self.dogName = dogName
    }
    
    func downloadDogImageURL() async {
        dogImageURL = await self.networkManager?.fetchDogImageURL(urlToGetDogImageURL: urlToGetDogImageURL)
    }
    
    func getDogImageURL() -> String? {
        return dogImageURL
    }
    
    func getDogName() -> String? {
        return dogName
    }
}

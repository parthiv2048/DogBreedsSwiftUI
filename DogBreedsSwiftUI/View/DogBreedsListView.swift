//
//  ContentView.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

struct DogBreedsListView: View {
    
    private var dogBreedsListVM: DogBreedsListVMProtocol?
    
    init(dogBreedsListVM: DogBreedsListVMProtocol? = nil) {
        self.dogBreedsListVM = dogBreedsListVM
    }
    
    var body: some View {
        NavigationStack {
            
            Text("Dog Breeds")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            List {
                ForEach(dogBreedsListVM?.getDogBreedsList() ?? []) { dogBreedInfo in
                    
                    let dogBreedName = dogBreedInfo.name ?? ""
                    let dogSubBreeds = dogBreedInfo.subBreeds
                    let urlToGetDogImageURL = "https://dog.ceo/api/breed/\(dogBreedName)/images/random"
                    
                    let dogImageVM = DogImageVM(
                        urlToGetDogImageURL: urlToGetDogImageURL,
                        networkManager: NetworkManager.shared,
                        dogName: dogBreedName
                    )
                    
                    NavigationLink(destination: DogImageView(dogImageVM: dogImageVM)) {
                        DogBreedsListCell(dogBreed: dogBreedName)
                    }
                    
                    ForEach(0..<(dogSubBreeds?.count ?? 0), id: \.self) { subIndex in
                        /// Sub-breeds need their own URL separate from main breed
                        let dogSubBreedName = dogSubBreeds?[subIndex] ?? ""
                        let urlToGetDogSubBreedImageURL = "https://dog.ceo/api/breed/\(dogBreedName)/\(dogSubBreedName)/images/random"
                        
                        let dogSubBreedImageVM = DogImageVM(
                            urlToGetDogImageURL: urlToGetDogSubBreedImageURL,
                            networkManager: NetworkManager.shared,
                            dogName: dogBreedName + "/" + dogSubBreedName
                        )
                        
                        NavigationLink(destination: DogImageView(dogImageVM: dogSubBreedImageVM)) {
                            DogSubBreedsListCell(dogSubBreed: dogSubBreeds?[subIndex] ?? "")
                        }
                    }
                }
            }
        }
        .task {
            await dogBreedsListVM?.downloadDogBreeds()
        }
    }
}

// MARK: Row that displays Dog Breed Name

struct DogBreedsListCell: View {
    var dogBreed: String
    
    var body: some View {
        Text(dogBreed)
            .fontWeight(.semibold)
    }
}

// MARK: Row that displays Dog Sub-breed Name

struct DogSubBreedsListCell: View {
    var dogSubBreed: String
    
    var body: some View {
        Text(dogSubBreed)
            .font(.body)
            .padding(.leading, 15)
    }
}

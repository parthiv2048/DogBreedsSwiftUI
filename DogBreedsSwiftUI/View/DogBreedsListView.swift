//
//  ContentView.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI
import Lottie

struct DogBreedsListView: View {
    
    // MARK: - Properties
    
    private var dogBreedsListVM: DogBreedsListVMProtocol?
    
    // MARK: - Initializer (Injection)
    
    init(dogBreedsListVM: DogBreedsListVMProtocol? = nil) {
        self.dogBreedsListVM = dogBreedsListVM
    }
    
    // MARK: - Dog Breeds Header View
    
    var dogBreedsHeader: some View {
        HStack {
            Text("Dog Breeds")
                .font(.largeTitle)
                .bold()
            
            LottieView(animation: .named("CuteDoggie"))
                .playing(loopMode: .loop)
                .frame(width: 100, height: 100)
        }
    }
    
    // MARK: - Body View
    
    var body: some View {
        NavigationStack {
            
            dogBreedsHeader
            
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

// MARK: Row View that displays Dog Breed Name

private struct DogBreedsListCell: View {
    var dogBreed: String
    
    var body: some View {
        Text(dogBreed)
            .fontWeight(.semibold)
    }
}

// MARK: Row View that displays Dog Sub-breed Name

private struct DogSubBreedsListCell: View {
    var dogSubBreed: String
    
    var body: some View {
        Text(dogSubBreed)
            .font(.body)
            .padding(.leading, 15)
    }
}

//
//  DogImageView.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

struct DogImageView: View {
    
    private var dogImageVM: DogImageVMProtocol?
    
    init(dogImageVM: DogImageVMProtocol? = nil) {
        self.dogImageVM = dogImageVM
    }
    
    var body: some View {
        Text(dogImageVM?.getDogName() ?? "")
            .font(.largeTitle)
            .padding()
        
        AsyncImage(url: URL(string: dogImageVM?.getDogImageURL() ?? "")) { image in
            image
                .resizable()
                .scaledToFit()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        } placeholder: {
            ProgressView()
        }
        .task {
            await dogImageVM?.downloadDogImageURL()
        }
    }
}

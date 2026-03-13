//
//  DogImageView.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct DogImageView: View {
    
    // MARK: - Properties
    
    private var dogImageVM: DogImageVMProtocol?
    
    // MARK: - Initializer (Injection)
    
    init(dogImageVM: DogImageVMProtocol? = nil) {
        self.dogImageVM = dogImageVM
    }
    
    // MARK: - Body View
    
    var body: some View {
        Text(dogImageVM?.getDogName() ?? "")
            .font(.largeTitle)
            .padding()
        
        WebImage(url: URL(string: dogImageVM?.getDogImageURL() ?? "")) { image in
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

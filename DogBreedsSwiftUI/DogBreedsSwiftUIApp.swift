//
//  DogBreedsSwiftUIApp.swift
//  DogBreedsSwiftUI
//
//  Created by Parthiv Ganguly on 2/23/26.
//

import SwiftUI

@main
struct DogBreedsSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            DogBreedsListView(dogBreedsListVM: DogBreedsListVM(networkManager: NetworkManager.shared))
        }
    }
}

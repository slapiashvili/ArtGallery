//
//  ArtGalleryScene.swift
//  artGallery
//
//  Created by Salome Lapiashvili on 23.12.23.
//

import SwiftUI

struct ArtGalleryScene: View {
    //MARK: -properties:
    @State private var isDarkMode = false
    @StateObject private var viewModel = ArtGalleryViewModel()
    
    private var header: some View {
        HStack {
            Spacer()
            Text("Minecraft Museum")
                .font(.title)
                .bold()
                .foregroundColor(Color("darkBrown"))

            Spacer()

            DarkModeButton(isDarkMode: $isDarkMode)
        }
        .padding()
        .background(Color("Cream"))
    }

    private var artGalleryItems: some View {
        LazyVStack {
            ForEach(viewModel.artPieces) { artPieceViewModel in
                ArtGalleryItemView(viewModel: artPieceViewModel)
            }
        }
        .background(Color("Cream"))
        .ignoresSafeArea()
    }
    //MARK: -body:
    var body: some View {
        ScrollView {
            VStack {
                header
                artGalleryItems
            }
        }
        .preferredColorScheme(isDarkMode ? .light : .dark)
        .background(Color("Cream"))
    }
}

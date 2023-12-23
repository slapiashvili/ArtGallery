//
//  ArtGalleryViewModel.swift
//  artGallery
//
//  Created by Salome Lapiashvili on 23.12.23.
//

import SwiftUI

final class ArtGalleryViewModel: ObservableObject {
    @Published var artPieces: [ArtPieceViewModel] = {
        var artworks: [ArtPieceViewModel] = []
        
        for i in 1...8 {
            let imageName = "artwork\(i)"
            let artPiece = ArtPieceModel(imageName: imageName)
            let artPieceViewModel = ArtPieceViewModel(artPiece: artPiece)
            artworks.append(artPieceViewModel)
        }

        return artworks
    }()
}

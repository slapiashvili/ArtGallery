//
//  ViewModel.swift
//  artGallery
//
//  Created by Salome Lapiashvili on 23.12.23.
//

import SwiftUI

final class ArtPieceViewModel: ObservableObject, Identifiable {
    @Published var artPiece: ArtPieceModel
    @Published var scale: CGFloat = 1.0
    @Published var rotation: Angle = .degrees(0)
    @Published var offsetX: CGFloat = 0
    @Published var offsetY: CGFloat = 0
    @Published var currentGesture: String = ""

    init(artPiece: ArtPieceModel) {
        self.artPiece = artPiece
    }
}

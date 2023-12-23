//
//  Model.swift
//  artGallery
//
//  Created by Salome Lapiashvili on 23.12.23.
//

import SwiftUI

final class ArtPieceModel: Identifiable {
    var id = UUID()
    var imageName: String

    init(imageName: String) {
        self.imageName = imageName
    }
}


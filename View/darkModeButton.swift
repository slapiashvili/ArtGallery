//
//  darkModeButton.swift
//  artGallery
//
//  Created by Salome Lapiashvili on 23.12.23.
//

import SwiftUI

//MARK: -dark mode:
struct DarkModeButton: View {
    @Binding var isDarkMode: Bool
    var body: some View {
        Button(action: {
            isDarkMode.toggle()
        }) {
            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color("darkBrown"))
        }
        .padding()
    }
}

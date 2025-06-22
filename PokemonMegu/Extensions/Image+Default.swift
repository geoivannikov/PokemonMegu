//
//  View+Default.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import SwiftUI

extension Image {
    static var hiddenDefault: some View {
        Image("default")
            .resizable()
            .scaledToFit()
            .hidden()
    }
}

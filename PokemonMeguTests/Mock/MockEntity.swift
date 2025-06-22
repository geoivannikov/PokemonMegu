//
//  MockEntity.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import SwiftUI
@testable import PokemonMegu

extension Pokemon {
    static func mock() -> Self {
        Pokemon(
            id: 25,
            name: "Pikachu",
            number: "#025",
            types: ["electric"],
            imgURL: "https://example.com/pikachu.png",
            height: 40,
            weight: 60,
            baseExperience: 112
        )
    }
}

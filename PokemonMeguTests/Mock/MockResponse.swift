//
//  MockResponse.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

@testable import PokemonMegu

extension PokemonListResponse {
    static func mock() -> Self {
        .init(results: [
            .init(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25")
        ])
    }
}

extension PokemonDetailResponse {
    static func mock() -> Self {
        .init(
            id: 25,
            name: "pikachu",
            types: [.init(type: .init(name: "electric", url: nil))],
            sprites: .init(
                other: .init(
                    officialArtwork: .init(
                        frontDefault: "https://example.com/pikachu.png"
                    )
                )
            ),
            height: 4,
            weight: 60,
            baseExperience: 112,
            forms: [.init(name: "pikachu", url: nil)]
        )
    }
}

extension PokemonSpeciesResponse {
    static func mock() -> Self {
        .init(
            flavorText: "Electric mouse Pokémon.",
            genus: "Mouse",
            formsCount: 1
        )
    }
}

extension PokemonEntry {
    static func mock() -> Self {
        .init(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon/25")
    }
}

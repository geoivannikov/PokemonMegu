//
//  PokemonListResponse.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Foundation

// MARK: - Pokemon List Response

struct PokemonListResponse: Decodable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}

// MARK: - Pokemon Detail Response

struct PokemonDetailResponse: Decodable {
    let id: Int
    let name: String
    let types: [PokemonTypeEntry]
    let sprites: PokemonSprites
    let height: Int
    let weight: Int
    let baseExperience: Int
    let forms: [NamedAPIResource]

    enum CodingKeys: String, CodingKey {
        case id, name, types, sprites, height, weight, forms
        case baseExperience = "base_experience"
    }
}

// MARK: - Type Info

struct PokemonTypeEntry: Decodable {
    let type: NamedAPIResource
}

// MARK: - Sprites

struct PokemonSprites: Decodable {
    let other: OtherSprites

    struct OtherSprites: Decodable {
        let officialArtwork: Artwork

        enum CodingKeys: String, CodingKey {
            case officialArtwork = "official-artwork"
        }
    }

    struct Artwork: Decodable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }
}

// MARK: - Shared Resource

struct NamedAPIResource: Decodable {
    let name: String
    let url: String?

    init(name: String, url: String? = nil) {
        self.name = name
        self.url = url
    }
}

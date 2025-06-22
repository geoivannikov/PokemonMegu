//
//  Pokemon.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import SwiftUI

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let number: String
    let types: [String]
    let imgURL: String
    let height: Int
    let weight: Int
    let baseExperience: Int
}

extension Pokemon {
    var backgroundColor: Color {
        guard let primaryType = types.first else {
            return .gray.opacity(0.2)
        }

        switch primaryType.lowercased() {
        case "normal": return .gray.opacity(0.8)
        case "fire": return .red.opacity(0.8)
        case "water": return .blue.opacity(0.8)
        case "electric": return .yellow.opacity(0.8)
        case "grass": return .green.opacity(0.8)
        case "ice": return .cyan.opacity(0.8)
        case "fighting": return .brown.opacity(0.8)
        case "poison": return .purple.opacity(0.8)
        case "ground": return .orange.opacity(0.8)
        case "flying": return .teal.opacity(0.8)
        case "psychic": return .pink.opacity(0.8)
        case "bug": return .mint.opacity(0.8)
        case "rock": return .indigo.opacity(0.8)
        case "ghost": return .black.opacity(0.8)
        case "dragon": return .blue.opacity(0.8)
        case "dark": return .black.opacity(0.8)
        case "steel": return .gray.opacity(0.8)
        case "fairy": return .pink.opacity(0.8)
        default: return .gray.opacity(0.8)
        }
    }
}

struct PokemonResponse {
    let id: Int
    let name: String
    let number: String
    let types: [String]
    let imageUrl: String
}

struct PokemonListResponse: Decodable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable {
    let name: String
    let url: String
}

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

struct PokemonTypeEntry: Decodable {
    let type: NamedAPIResource
}

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

struct NamedAPIResource: Decodable {
    let name: String
}


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

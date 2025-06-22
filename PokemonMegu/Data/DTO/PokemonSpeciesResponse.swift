//
//  PokemonSpeciesResponse.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Foundation

struct PokemonSpeciesResponse: Decodable {
    let flavorText: String
    let genus: String
    let formsCount: Int

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
        case genera
        case varieties
    }

    // MARK: - Nested types

    private struct FlavorTextEntry: Decodable {
        let flavor_text: String
        let language: NamedAPIResource
    }

    private struct GenusEntry: Decodable {
        let genus: String
        let language: NamedAPIResource
    }

    private struct Variety: Decodable {
        let is_default: Bool
    }

    private struct NamedAPIResource: Decodable {
        let name: String
    }

    // MARK: - Init

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        // Flavor Text
        let flavorEntries = try container.decode([FlavorTextEntry].self, forKey: .flavorTextEntries)
        self.flavorText = flavorEntries
            .first(where: { $0.language.name == "en" })?
            .flavor_text
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000c}", with: " ") ?? "No description available."

        // Genus
        let genusEntries = try container.decode([GenusEntry].self, forKey: .genera)
        self.genus = genusEntries
            .first(where: { $0.language.name == "en" })?
            .genus ?? "Unknown"

        // Varieties count
        let varieties = try container.decode([Variety].self, forKey: .varieties)
        self.formsCount = varieties.count
    }
}

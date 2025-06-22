//
//  PokemonSpecies.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

struct PokemonSpecies: Decodable {
    let flavorText: String
    let genus: String
    let formsCount: Int

    enum CodingKeys: String, CodingKey {
        case flavor_text_entries
        case genera
        case varieties
    }

    struct FlavorTextEntry: Decodable {
        let flavor_text: String
        let language: Language
    }

    struct GenusEntry: Decodable {
        let genus: String
        let language: Language
    }

    struct Language: Decodable {
        let name: String
    }

    struct Variety: Decodable {
        let is_default: Bool
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let entries = try container.decode([FlavorTextEntry].self, forKey: .flavor_text_entries)
        self.flavorText = entries
            .first(where: { $0.language.name == "en" })?
            .flavor_text
            .replacingOccurrences(of: "\n", with: " ")
            .replacingOccurrences(of: "\u{000c}", with: " ") ?? "No description."

        let genera = try container.decode([GenusEntry].self, forKey: .genera)
        self.genus = genera.first(where: { $0.language.name == "en" })?.genus ?? "Unknown"

        let varieties = try container.decode([Variety].self, forKey: .varieties)
        self.formsCount = varieties.count
    }
}

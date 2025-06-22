//
//  PokemonRemoteDataSource.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import Foundation

protocol PokemonRemoteDataSourceProtocol {
    func fetchPokemonsList(offset: Int, limit: Int) async throws -> PokemonListResponse
    func fetchPokemon(entry: PokemonEntry) async throws -> PokemonDetailResponse
    func fetchPokemonDescription(name: String) async throws -> PokemonSpecies
}

final class PokemonRemoteDataSource: PokemonRemoteDataSourceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchPokemonsList(offset: Int, limit: Int) async throws -> PokemonListResponse {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!
        let (data, _) = try await session.data(from: url)
        let list = try JSONDecoder().decode(PokemonListResponse.self, from: data)
        return list
    }
    
    func fetchPokemon(entry: PokemonEntry) async throws -> PokemonDetailResponse {
        guard let detailURL = URL(string: entry.url) else {
            print("❌ Invalid detail URL for \(entry.name)")
            throw APIError.invalidURL(entry.url)
        }

        let (detailData, _) = try await URLSession.shared.data(from: detailURL)
        let detail = try JSONDecoder().decode(PokemonDetailResponse.self, from: detailData)

        return detail
    }
    
    func fetchPokemonDescription(name: String) async throws -> PokemonSpecies {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon-species/\(name)")!
        let (data, _) = try await URLSession.shared.data(from: url)
//        print("QLog \(String(data: data, encoding: .utf8))")
        return try JSONDecoder().decode(PokemonSpecies.self, from: data)
    }
}

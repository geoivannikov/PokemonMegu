//
//  PokemonRemoteDataSourceMock.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

@testable import PokemonMegu

final class PokemonRemoteDataSourceMock: PokemonRemoteDataSourceProtocol {
    var fetchListCalled = false
    var fetchPokemonCalled = false

    var fetchListResult: PokemonListResponse = .mock()
    var fetchDetailResults: [PokemonDetailResponse] = [.mock()]

    var shouldThrowOnList = false

    func fetchPokemonsList(offset: Int, limit: Int) async throws -> PokemonListResponse {
        fetchListCalled = true
        if shouldThrowOnList {
            throw APIError.invalidResponse(nil)
        }
        return fetchListResult
    }

    func fetchPokemon(entry: PokemonEntry) async throws -> PokemonDetailResponse {
        fetchPokemonCalled = true
        guard !fetchDetailResults.isEmpty else {
            throw APIError.invalidResponse(nil)
        }
        return fetchDetailResults.removeFirst()
    }

    func fetchPokemonDescription(name: String) async throws -> PokemonSpeciesResponse {
        fatalError("Not needed for this test")
    }
}

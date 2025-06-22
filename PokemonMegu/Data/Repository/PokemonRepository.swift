//
//  PokemonRepository.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

protocol PokemonRepositoryProtocol {
    func getPokemons(offset: Int, limit: Int) async throws -> PokemonListResponse
    func fetchPokemon(entry: PokemonEntry) async throws -> PokemonDetailResponse
    func fetchPokemonDescription(name: String) async throws -> PokemonSpecies
}

final class PokemonRepository: PokemonRepositoryProtocol {
    private let remoteDataSource: PokemonRemoteDataSource

    init(remoteDataSource: PokemonRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }

    func getPokemons(offset: Int, limit: Int) async throws -> PokemonListResponse {
        try await remoteDataSource.fetchPokemonsList(offset: offset, limit: limit)
    }
    
    func fetchPokemon(entry: PokemonEntry) async throws -> PokemonDetailResponse {
        try await remoteDataSource.fetchPokemon(entry: entry)
    }
    
    func fetchPokemonDescription(name: String) async throws -> PokemonSpecies {
        try await remoteDataSource.fetchPokemonDescription(name: name)
    }
}

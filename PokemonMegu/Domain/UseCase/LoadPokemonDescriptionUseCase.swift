//
//  LoadPokemonDescriptionUseCase.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

protocol LoadPokemonDescriptionUseCaseProtocol {
    func execute() async throws -> PokemonDetails
}

final class LoadPokemonDescriptionUseCase: LoadPokemonDescriptionUseCaseProtocol {
    private let pokemon: Pokemon
    private let remoteDataSource: PokemonRemoteDataSourceProtocol

    init(remoteDataSource: PokemonRemoteDataSourceProtocol, pokemon: Pokemon) {
        self.remoteDataSource = remoteDataSource
        self.pokemon = pokemon
    }

    func execute() async throws -> PokemonDetails {
        let speciesResponse = try await remoteDataSource.fetchPokemonDescription(name: pokemon.name)
        return PokemonDetails(pokemon: pokemon, pokemonSpeciesResponse: speciesResponse)
    }
}

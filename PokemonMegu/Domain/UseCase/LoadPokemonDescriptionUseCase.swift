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
    private let repository: PokemonRepository

    init(repository: PokemonRepository, pokemon: Pokemon) {
        self.repository = repository
        self.pokemon = pokemon
    }

    func execute() async throws -> PokemonDetails {
        let pokemonListResponse = try await repository.fetchPokemonDescription(name: pokemon.name)
        return PokemonDetails(name: pokemon.name,
                              description: pokemonListResponse.flavorText,
                              weight: pokemon.weight,
                              height: pokemon.height,
                              baseExep: pokemon.baseExperience,
                              species: pokemonListResponse.genus,
                              types: pokemon.types,
                              formsCount: pokemonListResponse.formsCount,
                              backgroundColor: pokemon.backgroundColor)
    }
}


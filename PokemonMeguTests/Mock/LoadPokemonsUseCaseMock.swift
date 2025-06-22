//
//  LoadPokemonsUseCaseMock.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

@testable import PokemonMegu

final class LoadPokemonsUseCaseMock: LoadPokemonsUseCaseProtocol {
    var result: Result<[Pokemon], Error> = .success([])
    var receivedOffset: Int?
    var receivedLimit: Int?

    func execute(offset: Int, limit: Int) async throws -> [Pokemon] {
        receivedOffset = offset
        receivedLimit = limit
        switch result {
        case .success(let pokemons): return pokemons
        case .failure(let error): throw error
        }
    }
}

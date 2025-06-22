//
//  PokemonListViewModelTests.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Testing
@testable import PokemonMegu

@MainActor
struct PokemonListViewModelTests {
    @Test
    func test_loadNextPage_successfullyAppendsPokemons() async throws {
        let mock = LoadPokemonsUseCaseMock()
        mock.result = .success([Pokemon.mock()])

        let viewModel = PokemonListViewModel(loadUseCase: mock)
        await viewModel.loadNextPage()

        #expect(viewModel.pokemons.count == 1)
        #expect(viewModel.pokemons[0].name == "Pikachu")
        #expect(mock.receivedOffset == 0)
        #expect(mock.receivedLimit == 20)
    }

    @Test
    func test_loadNextPage_setsErrorMessageOnFailure() async throws {
        let mock = LoadPokemonsUseCaseMock()
        mock.result = .failure(APIError.invalidResponse(nil))

        let viewModel = PokemonListViewModel(loadUseCase: mock)
        await viewModel.loadNextPage()

        #expect(viewModel.pokemons.isEmpty)
        #expect(viewModel.errorMessage != nil)
    }
}

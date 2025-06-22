//
//  LoadPokemonsUseCaseTests.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Testing
@testable import PokemonMegu

struct LoadPokemonsUseCaseTests {
    @Test
    func test_LoadPokemonsUseCase_executesSuccessfully() async throws {
        let mock = PokemonRemoteDataSourceMock()
        mock.fetchListResult = .init(results: [.mock()])
        mock.fetchDetailResults = [.mock()]

        let sut = LoadPokemonsUseCase(remoteDataSource: mock)
        let result = try await sut.execute(offset: 0, limit: 1)

        #expect(mock.fetchListCalled)
        #expect(mock.fetchPokemonCalled)
        #expect(result.count == 1)
        #expect(result[0].name == "Pikachu")
    }
    
    @Test
    func test_LoadPokemonsUseCase_throws_whenFetchListFails() async {
        let mock = PokemonRemoteDataSourceMock()
        mock.shouldThrowOnList = true

        let sut = LoadPokemonsUseCase(remoteDataSource: mock)

        do {
            _ = try await sut.execute(offset: 0, limit: 1)
            #expect(Bool(false), "Expected error to be thrown")
        } catch {
            #expect(error is APIError)
        }
    }
    
    // etc
}

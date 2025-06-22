//
//  PokemonRemoteDataSourceTests.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Foundation
import Testing
@testable import PokemonMegu

struct PokemonRemoteDataSourceTests {
    @Test
    func test_fetchPokemonsList_success() async throws {
        let expected = PokemonListResponse.mock()
        let session = makeMockSession(for: "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0", returning: expected)
        let sut = PokemonRemoteDataSource(session: session)

        let result = try await sut.fetchPokemonsList(offset: 0, limit: 20)

        #expect(result.results.first?.name == expected.results.first?.name)
    }

    @Test
    func test_fetchPokemon_success() async throws {
        let expected = PokemonDetailResponse.mock()
        let entry = PokemonEntry.mock()
        let session = makeMockSession(for: entry.url, returning: expected)
        let sut = PokemonRemoteDataSource(session: session)

        let result = try await sut.fetchPokemon(entry: entry)

        #expect(result.name == expected.name)
    }

    @Test
    func test_fetchPokemonDescription_success() async throws {
        let expected = PokemonSpeciesResponse.mock()
        let session = makeMockSession(for: "https://pokeapi.co/api/v2/pokemon-species/pikachu", returning: expected)
        let sut = PokemonRemoteDataSource(session: session)

        let result = try await sut.fetchPokemonDescription(name: "pikachu")

        #expect(result.flavorText == expected.flavorText)
    }

    @Test
    func test_fetchPokemon_invalidURL() async {
        let sut = PokemonRemoteDataSource()

        do {
            _ = try await sut.fetchPokemon(entry: .init(name: "pikachu", url: "not a url"))
            #expect(Bool(false), "Expected error to be thrown")
        } catch {
            #expect((error as? URLError)?.code == .unsupportedURL)
        }
    }
    
    func makeMockSession<T: Encodable>(
        for urlString: String?,
        returning value: T? = nil,
        statusCode: Int = 200,
        data: Data? = nil
    ) -> URLSession {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLSessionMock.self]
        URLSessionMock.stubResponse(for: urlString, statusCode: statusCode, data: data ?? (try? JSONEncoder().encode(value)))
        return URLSession(configuration: config)
    }
    
    // etc
}

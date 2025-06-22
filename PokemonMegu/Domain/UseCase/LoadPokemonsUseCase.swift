//
//  LoadPokemonsUseCase.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

protocol LoadPokemonsUseCaseProtocol {
    func execute(offset: Int, limit: Int) async throws -> [Pokemon]
}

final class LoadPokemonsUseCase: LoadPokemonsUseCaseProtocol {
    private let remoteDataSource: PokemonRemoteDataSourceProtocol

    init(remoteDataSource: PokemonRemoteDataSourceProtocol = DIContainer.shared.resolve()) {
        self.remoteDataSource = remoteDataSource
    }

    func execute(offset: Int, limit: Int) async throws -> [Pokemon] {
        let response = try await remoteDataSource.fetchPokemonsList(offset: offset, limit: limit)
        let entries = response.results

        var detailResponses: [PokemonDetailResponse] = []

        try await withThrowingTaskGroup(of: PokemonDetailResponse?.self) { group in
            for entry in entries {
                group.addTask {
                    try? await self.remoteDataSource.fetchPokemon(entry: entry)
                }
            }

            for try await response in group {
                if let model = response {
                    detailResponses.append(model)
                }
            }
        }

        return detailResponses.map { Pokemon(detail: $0) }
    }
}

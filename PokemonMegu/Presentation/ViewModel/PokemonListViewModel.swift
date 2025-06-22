//
//  PokemonListViewModel.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import Foundation

final class PokemonListViewModel: ObservableObject {
    // MARK: - Public State

    @Published private(set) var pokemons: [Pokemon] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let loadUseCase: LoadPokemonsUseCaseProtocol

    // MARK: - Paging

    var offset: Int = 0
    private let pageSize: Int = 20

    // MARK: - Init

    init(loadUseCase: LoadPokemonsUseCaseProtocol) {
        self.loadUseCase = loadUseCase
        Task { await loadNextPage() }
    }

    // MARK: - Public Methods

    func loadNextPage() async {
        
        
        await setLoading(true)

        do {
            let newPokemons = try await loadUseCase.execute(offset: offset, limit: pageSize)

            
            await MainActor.run {
                pokemons.append(contentsOf: newPokemons)
                offset += pageSize
            }

        } catch {
            await setError(message: error.localizedDescription)
        }

        await setLoading(false)
    }

    // MARK: - Private Helpers

    private func setLoading(_ value: Bool) async {
        await MainActor.run { isLoading = value }
    }

    private func setError(message: String) async {
        await MainActor.run { errorMessage = message }
    }
}

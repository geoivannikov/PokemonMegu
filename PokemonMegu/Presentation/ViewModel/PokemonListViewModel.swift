//
//  PokemonListViewModel.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import Foundation

@MainActor
final class PokemonListViewModel: ObservableObject {
    // MARK: - Public State

    @Published private(set) var pokemons: [Pokemon] = []
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let loadUseCase: LoadPokemonsUseCaseProtocol

    // MARK: - Paging

    private(set) var offset = 0
    private let pageSize = 20

    // MARK: - Init

    init(loadUseCase: LoadPokemonsUseCaseProtocol) {
        self.loadUseCase = loadUseCase
    }

    // MARK: - Public Methods

    func loadNextPage() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            let newPokemons = try await loadUseCase.execute(offset: offset, limit: pageSize)
            pokemons.append(contentsOf: newPokemons)
            offset += pageSize
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

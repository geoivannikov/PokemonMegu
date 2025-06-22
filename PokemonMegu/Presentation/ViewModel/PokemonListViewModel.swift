//
//  PokemonListViewModel.swift
//  PokemonMegu
//

import Foundation

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
        guard await MainActor.run(body: { !isLoading }) else { return }

        await MainActor.run {
            isLoading = true
        }

        defer {
            Task { [self] in
                await MainActor.run {
                    isLoading = false
                }
            }
        }

        do {
            let newPokemons = try await loadUseCase.execute(offset: offset, limit: pageSize)

            await MainActor.run { [self] in
                pokemons.append(contentsOf: newPokemons)
                offset += pageSize
            }
        } catch {
            await MainActor.run { [self] in
                errorMessage = error.localizedDescription
            }
        }
    }
}

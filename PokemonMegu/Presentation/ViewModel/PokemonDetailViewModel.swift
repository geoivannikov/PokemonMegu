//
//  PokemonDetailViewModel.swift
//  PokemonMegu
//

import Foundation

final class PokemonDetailViewModel: ObservableObject {
    // MARK: - Public State

    @Published private(set) var details = PokemonDetails()
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let loadUseCase: LoadPokemonDescriptionUseCaseProtocol
    private let pokemon: Pokemon

    // MARK: - Init

    init(loadUseCase: LoadPokemonDescriptionUseCaseProtocol = DIContainer.shared.resolve(),
         pokemon: Pokemon) {
        self.loadUseCase = loadUseCase
        self.pokemon = pokemon
    }

    // MARK: - Public Methods

    func load() async {
        guard await MainActor.run(body: { [self] in !isLoading }) else { return }

        await MainActor.run { [self] in
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
            let result = try await loadUseCase.execute(pokemon: pokemon)

            await MainActor.run { [self] in
                details = result
            }
        } catch {
            await MainActor.run { [self] in
                errorMessage = error.localizedDescription
            }
        }
    }
}

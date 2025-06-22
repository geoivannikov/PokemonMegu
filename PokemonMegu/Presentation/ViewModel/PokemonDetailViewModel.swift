//
//  PokemonDetailViewModel.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Foundation

@MainActor
final class PokemonDetailViewModel: ObservableObject {
    @Published private(set) var details = PokemonDetails()
    @Published private(set) var isLoading = false
    @Published var errorMessage: String?

    private let loadUseCase: LoadPokemonDescriptionUseCaseProtocol

    init(loadUseCase: LoadPokemonDescriptionUseCaseProtocol) {
        self.loadUseCase = loadUseCase
    }

    func load() async {
        guard !isLoading else { return }

        isLoading = true
        defer { isLoading = false }

        do {
            details = try await loadUseCase.execute()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}

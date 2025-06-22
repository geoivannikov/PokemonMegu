//
//  PokemonDetailViewModel.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import Foundation

final class PokemonDetailViewModel: ObservableObject {
    @Published private(set) var details: PokemonDetails = PokemonDetails(name: "",
                                                                         description: "",
                                                                         weight: 0,
                                                                         height: 0,
                                                                         baseExep: 0,
                                                                         species: "",
                                                                         types: [],
                                                                         formsCount: 0,
                                                                         backgroundColor: .clear)
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?

    // MARK: - Dependencies

    private let loadUseCase: LoadPokemonDescriptionUseCaseProtocol

    // MARK: - Paging

    var offset: Int = 0
    private let pageSize: Int = 20

    // MARK: - Init

    init(loadUseCase: LoadPokemonDescriptionUseCaseProtocol) {
        self.loadUseCase = loadUseCase
        Task { await loadDescription() }
    }
    
    private func loadDescription() async {
        do {
            let details: PokemonDetails = try await loadUseCase.execute()
            
            await MainActor.run {
                self.details = details
            }

        } catch {
//            await setError(message: error.localizedDescription)
        }
    }
}

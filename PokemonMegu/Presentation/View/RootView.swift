//
//  RootView.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import SwiftUI

struct RootView: View {
    @StateObject var viewModel: PokemonListViewModel
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            PokemonListView(viewModel: viewModel)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .detail(let pokemon):
                        let useCase = LoadPokemonDescriptionUseCase(
                            remoteDataSource: PokemonRemoteDataSource(),
                            pokemon: pokemon
                        )
                        let detailVM = PokemonDetailViewModel(loadUseCase: useCase)
                        PokemonDetailView(viewModel: detailVM)
                    }
                }
        }
    }
}

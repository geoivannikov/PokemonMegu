//
//  RootView.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var coordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            PokemonListView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .detail(let pokemon):
                        let detailVM = PokemonDetailViewModel(pokemon: pokemon)
                        PokemonDetailView(viewModel: detailVM)
                    }
                }
        }
    }
}

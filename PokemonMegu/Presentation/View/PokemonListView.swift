//
//  PokemonListView.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject private var coordinator: Coordinator
    @StateObject private var viewModel: PokemonListViewModel

    init(viewModel: PokemonListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    private let columns = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack {
                HStack {
                    Spacer()
                    Image("pokeball")
                        .padding(.trailing, 16)
                }
                .ignoresSafeArea()
                Spacer()
            }
            .padding(-16)
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(viewModel.pokemons) { pokemon in
                        let isLast = (pokemon.id == viewModel.pokemons.last?.id)
                        PokemonListItem(pokemon: pokemon, isLast: isLast) {
                            Task { await viewModel.loadNextPage() }
                        }
                    }
                }
                .padding()
            }
            .scrollIndicators(.hidden)
            .scrollBounceBehavior(.basedOnSize)

            if viewModel.isLoading {
                ProgressView()
                    .padding()
            }
        }
        .navigationTitle("Pokedex")
        .navigationBarTitleDisplayMode(.large)
        .task {
            await viewModel.loadNextPage()
        }
    }
}


private struct PokemonListItem: View {
    @EnvironmentObject var coordinator: Coordinator
    let pokemon: Pokemon
    let isLast: Bool
    let onAppear: () -> Void

    var body: some View {
        Button {
            coordinator.showDetail(pokemon: pokemon)
        } label: {
            PokemonCardView(pokemon: pokemon)
        }
        .onAppear {
            if isLast { onAppear() }
        }
    }
}

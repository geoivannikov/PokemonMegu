//
//  PokemonMeguApp.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import SwiftUI

@main
struct PokemonMeguApp: App {
    var body: some Scene {
        WindowGroup {
            let remote = PokemonRemoteDataSource()
            let repo = PokemonRepository(remoteDataSource: remote)
            let useCase = LoadPokemonsUseCase(repository: repo)
            let vm = PokemonListViewModel(loadUseCase: useCase)

            PokemonListView(viewModel: vm)
        }
    }
}

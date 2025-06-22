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
            let coordinator = Coordinator()

            RootView().environmentObject(coordinator)
        }
    }
    
    init() {
        setupDependencies()
    }
    
    private func setupDependencies() {
        DIContainer.shared.registerAll()
    }
}

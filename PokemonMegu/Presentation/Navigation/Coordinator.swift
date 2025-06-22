//
//  Coordinator.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

import SwiftUI

final class Coordinator: ObservableObject {
    @Published var path = NavigationPath()

    func showDetail(pokemon: Pokemon) {
        path.append(AppRoute.detail(pokemon))
    }
}

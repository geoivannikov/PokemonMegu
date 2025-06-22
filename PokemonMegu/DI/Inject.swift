//
//  Inject.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 22.06.2025.
//

@propertyWrapper
struct Inject<T> {
    let wrappedValue: T

    init(resolver: Resolver = DIContainer.shared) {
        self.wrappedValue = resolver.resolve()
    }
}

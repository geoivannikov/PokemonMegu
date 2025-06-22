//
//  LoadPokemonsUseCase.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

protocol LoadPokemonsUseCaseProtocol {
    func execute(offset: Int, limit: Int) async throws -> [Pokemon]
}

final class LoadPokemonsUseCase: LoadPokemonsUseCaseProtocol {
    private let repository: PokemonRepository

    init(repository: PokemonRepository) {
        self.repository = repository
    }

    func execute(offset: Int, limit: Int) async throws -> [Pokemon] {
        let pokemonListResponse = try await repository.getPokemons(offset: offset, limit: limit)
        
        return await withTaskGroup(of: PokemonDetailResponse?.self) { group in
            for entry in pokemonListResponse.results {
                group.addTask { [weak self] in
                    do {
                        return try await self?.repository.fetchPokemon(entry: entry)
                    } catch {
                        print("❌ Failed to load details for \(entry.name): \(error)")
                        return nil
                    }
                }
            }
            
            var result: [PokemonDetailResponse] = []

            for await model in group {
                if let model = model {
                    result.append(model)
                }
            }
            
            result.forEach {
                print($0)
            }
            
            return result.map {
                Pokemon(id: $0.id,
                        name: $0.name.capitalized,
                        number: String(format: "#%03d", $0.id),
                        types: $0.types.map { $0.type.name.capitalized },
                        imgURL: $0.sprites.other.officialArtwork.frontDefault,
                        height: $0.height,
                        weight: $0.weight,
                        baseExperience: $0.baseExperience)
            }
        }
    }
}


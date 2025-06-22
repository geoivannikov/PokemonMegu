//
//  PokemonCardView.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(pokemon.name)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)

                HStack {
                    VStack {
                        ForEach(pokemon.types, id: \.self) { type in
                            Text(type)
                                .font(.system(size: 8, weight: .bold))
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.white.opacity(0.2))
                                .foregroundColor(.white)
                                .cornerRadius(6)
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }.padding(.top, 16)
            ZStack {
                VStack {
                    Spacer()
                    Image("subtract")
                }
                VStack(alignment: .trailing) {
                    Text(pokemon.number)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white.opacity(0.2))
                        .padding(.trailing, 8)
                    AsyncImage(url: URL(string: pokemon.imgURL)) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                        default:
                            Image("default")
                                .resizable()
                                .scaledToFit()
                                .hidden()
                        }
                    }
                }
            }
        }
        .padding([.leading, .top], 8)
        .background(pokemon.backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

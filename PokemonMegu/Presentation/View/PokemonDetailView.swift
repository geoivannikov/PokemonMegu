//
//  PokemonDetailView.swift
//  PokemonMegu
//
//  Created by Ivannikov-EXTERNAL Georgiy on 19.06.2025.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: PokemonDetailViewModel
    
    init(viewModel: PokemonDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .top) {
            viewModel.details.backgroundColor
                .ignoresSafeArea()
            VStack(spacing: 0) {
                ScrollView {
                    VStack(alignment: .leading, spacing: 32) {
                        DescriptionSection(description: viewModel.details.description)

                        HeightWeightSection(
                            height: viewModel.details.height,
                            weight: viewModel.details.weight
                        )

                        InfoSection(
                            baseExperience: viewModel.details.baseExperience,
                            species: viewModel.details.species,
                            formsCount: viewModel.details.formsCount
                        )

                        TypeSection(
                            types: viewModel.details.types,
                            color: viewModel.details.backgroundColor
                        )

                        Spacer(minLength: 40)
                    }
                    .padding(20)
                }
            }
            .background(
                Color.white
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                    .ignoresSafeArea(.container, edges: [.horizontal, .bottom])
            )
            .padding(.top, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .medium))
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text(viewModel.details.name.capitalized)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct DescriptionSection: View {
    let description: String

    var body: some View {
        Text(description)
            .font(.system(size: 14))
            .padding(.top)
    }
}

private struct HeightWeightSection: View {
    let height: Int
    let weight: Int

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Height")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Text("\(height) cm")
                    .font(.system(size: 14))
            }
            Spacer()
            VStack(alignment: .leading) {
                Text("Weight")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.gray)
                Text("\(weight) kg")
                    .font(.system(size: 14))
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 5, x: 0, y: 3)
    }
}

private struct InfoSection: View {
    let baseExperience: Int
    let species: String
    let formsCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Info")
                .font(.headline)
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Base exp:")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                    Text("Species:")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                    Text("Forms count:")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
                VStack(alignment: .leading, spacing: 16) {
                    Text("\(baseExperience) exp")
                        .font(.system(size: 14))
                    Text(species)
                        .font(.system(size: 14))
                    Text("\(formsCount)")
                        .font(.system(size: 14))
                }
            }
        }
    }
}

private struct TypeSection: View {
    let types: [String]
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Type")
                .font(.headline)
            HStack {
                ForEach(types, id: \.self) { type in
                    Text(type.capitalized)
                        .foregroundColor(.white)
                        .font(.caption.bold())
                        .padding(.horizontal, 16)
                        .padding(.vertical, 4)
                        .background(color)
                        .cornerRadius(8)
                }
            }
        }
    }
}

//
//  GameView.swift
//  HueHunt
//
//  Created by Yaroslav Sedyshev on 13.10.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: viewModel.columns, spacing: 2) {
                ForEach(0...15, id: \.self) { index in
                    Rectangle()
                        .id(UUID())
                        .frame(width: 75, height: 75)
                        .foregroundColor(viewModel.colors[index])
                        .cornerRadius(12)
                        .transition(.opacity.combined(with: .scale(0.25)))
                        .onTapGesture {
                            viewModel.handleUserInput(index)
                            withAnimation(.smooth(duration: 0.15, extraBounce: 0.2)) {
                                viewModel.generateColors()
                            }
                        }
                }
            }
            .navigationTitle("Hue Hunt")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct Blurred: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blur(radius: 75)
    }
}

struct Normas: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blur(radius: 0)
    }
}

//#Preview {
//    GameView()
//}

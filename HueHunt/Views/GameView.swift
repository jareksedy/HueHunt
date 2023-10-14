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
                    Button("") {
                        withAnimation(.bouncy(duration: 0.2)) {
                            viewModel.handleUserInput(index)
                        }
                    }
                    .buttonStyle(ColorButtonStyle(color: viewModel.colors[index],
                                                  mark: viewModel.marks[index]))
                }
            }
            .navigationTitle("HueHunt")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

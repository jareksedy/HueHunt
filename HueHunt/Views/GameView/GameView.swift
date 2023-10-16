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
            
            Spacer()
            
            HStack {
                Text("Round: \(viewModel.round)")
                    .monospacedDigit()
                    .font(.system(size: 14))
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(.accentColor)
                
                Spacer()
                
                Text("Health: \(viewModel.health) / 3")
                    .monospacedDigit()
                    .font(.system(size: 14))
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(.accentColor)
                
            }
            .padding([.leading, .trailing], Config.padding + 8)

            LazyVGrid(columns: viewModel.columns, spacing: Config.spacing) {
                ForEach(0...Config.cells - 1, id: \.self) { index in
                    Button("") {
                        withAnimation(.bouncy(duration: 0.2)) {
                            viewModel.handleUserInput(index)
                        }
                    }
                    .buttonStyle(ColorButtonStyle(color: viewModel.colors[index],
                                                  mark: viewModel.marks[index]))
                }
            }
            .padding(Config.padding)
            .navigationTitle("Hue Hunt")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                } label: {
                    Image(systemName: "gearshape.fill")
                }
            }
        }
    }
}

#Preview {
    MainTabView()
}

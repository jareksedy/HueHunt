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
            VStack {
                Spacer()
                    .frame(maxHeight: 50)
                
                HStack {
                    Text("Find duplicate colors 🎨 in the shortest possible time")
                        .font(.system(size: 18, weight: .bold))
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundStyle(LinearGradient(colors: [.accentColor, .green], startPoint: .leading, endPoint: .trailing))
                    
                    Spacer()
                }
                .padding(25)
                .background(.white)
                .cornerRadius(10)
                .padding([.leading, .trailing], Config.padding)
                
                Spacer()
                
                ScoreView(round: viewModel.round, health: viewModel.health, startDate: viewModel.startDate)
                
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
                .navigationTitle("Hue 🐠 Hunt")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
                
                Spacer()
            }
            .background(Color.indigoLight.ignoresSafeArea())
        }
    }
}

#Preview {
    MainTabView()
}

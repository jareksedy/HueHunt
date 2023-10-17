//
//  GameView.swift
//  HueHunt
//
//  Created by Yaroslav Sedyshev on 13.10.2023.
//

import SwiftUI

struct GameView: View {
    @StateObject var viewModel = GameViewModel()
    @State var timeElapsed = Date()
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    var body: some View {
        NavigationStack {
            
            Spacer()
            
            HStack {
                HStack {
                    Text("Round:")
                        .monospacedDigit()
                        .font(.system(size: 18, weight: .bold))
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundColor(.accentColor)
                        .transition(.push(from: .top))
                    
                    Text("\(viewModel.round)")
                        .id(viewModel.round)
                        .transition(.push(from: .bottom))
                        .monospacedDigit()
                        .font(.system(size: 18, weight: .bold))
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundColor(.accentColor)
                }
                
                Spacer()
                
                HStack {
                    Image(systemName: "clock.fill")
                        .symbolEffect(.bounce, value: minutes)
                        .font(.system(size: 13))
                        .foregroundColor(.accentColor)
                        .padding(.top, 0.5)
                        .padding(.trailing, 1.8)
                    
                    Text("\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))")
                        .onReceive(viewModel.timer) { dateTime in
                            let components = Calendar.current.dateComponents([.minute, .second], from: viewModel.startDate, to: dateTime)
                            minutes = components.minute ?? 0
                            seconds = components.second ?? 0
                        }
                        .monospacedDigit()
                        .font(.system(size: 18, weight: .bold))
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundColor(.accentColor)
                }.padding(.trailing, 10)

                HStack {
                    Image(systemName: "heart.fill")
                        .symbolEffect(.bounce, value: viewModel.health)
                        .font(.system(size: 13))
                        .foregroundColor(.accentColor)
                        .padding(.top, 0.5)
                    
                    Text("\(viewModel.health)")
                        .id(viewModel.health)
                        .monospacedDigit()
                        .font(.system(size: 18, weight: .bold))
                        .bold()
                        .fontDesign(.rounded)
                        .foregroundColor(.accentColor)
                        .transition(.push(from: .top))
                }

                
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

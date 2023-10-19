//
//  ScoreView.swift
//  HueHunt
//
//  Created by Ярослав on 19.10.2023.
//

import SwiftUI

struct ScoreView: View {
    @StateObject var viewModel = GameViewModel()
    
    var round: Int
    var health: Int
    var startDate: Date
    
    @State var timeElapsed = Date()
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    
    var body: some View {
        HStack {
            HStack {
                Text("Round:")
                    .monospacedDigit()
                    .font(.system(size: 18, weight: .bold))
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(.accentColor)
                    .transition(.push(from: .top))
                
                Text("\(round)")
                    .id(round)
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
                        let components = Calendar.current.dateComponents([.minute, .second], from: startDate, to: dateTime)
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
                    .symbolEffect(.bounce, value: health)
                    .font(.system(size: 13))
                    .foregroundColor(.accentColor)
                    .padding(.top, 0.5)
                
                Text("\(health)")
                    .id(health)
                    .monospacedDigit()
                    .font(.system(size: 18, weight: .bold))
                    .bold()
                    .fontDesign(.rounded)
                    .foregroundColor(.accentColor)
                    .transition(.push(from: .top))
            }
            
            
        }
        .padding([.leading, .trailing], Config.padding + 4)
    }
}

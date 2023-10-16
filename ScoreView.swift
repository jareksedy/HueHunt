//
//  ScoreView.swift
//  HueHunt
//
//  Created by Ярослав on 16.10.2023.
//

import SwiftUI

struct ScoreView: View {
    var body: some View {
        HStack {
            HStack {
                Text("00:08:49")
                    .font(.body)
                    .monospacedDigit()
                    .fontWeight(.black)
                    .fontDesign(.rounded)
                    .monospacedDigit()
                    .foregroundColor(.white)
            }
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 10)
            .background(Capsule().foregroundColor(.accentColor))
            
            Spacer()
            
            HStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.white)
                    .symbolEffect(.bounce, value: true)
                
                Text("2 / 3")
                    .font(.body)
                    .monospacedDigit()
                    .fontWeight(.black)
                    .fontDesign(.rounded)
                    .monospacedDigit()
                    .foregroundColor(.white)
            }
            .padding([.leading, .trailing], 15)
            .padding([.top, .bottom], 10)
            .background(Capsule().foregroundColor(.accentColor))
        }
        .padding([.leading, .trailing], Config.padding)
    }
}

#Preview {
    ScoreView()
}

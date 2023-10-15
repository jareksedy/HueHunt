//
//  MainTabView.swift
//  HueHunt
//
//  Created by Ярослав on 15.10.2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            GameView()
                .tabItem {
                    Label("Game", systemImage: "rectangle.grid.2x2.fill")
                        .symbolEffect(.bounce, value: selection == 0)
                }
                .tag(0)
            
            StatsView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                        .symbolEffect(.bounce, value: selection == 1)
                }
                .tag(1)
        }
    }
}

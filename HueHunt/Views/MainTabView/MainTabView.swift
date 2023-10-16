//
//  MainTabView.swift
//  HueHunt
//
//  Created by Ярослав on 15.10.2023.
//

import SwiftUI

struct MainTabView: View {
    @State private var selection = 0
    
    init() {
        UINavigationBar.appearance().titleTextAttributes =
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold).rounded(),
         NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
        
        UINavigationBar.appearance().largeTitleTextAttributes =
        [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 36, weight: .bold).rounded(),
         NSAttributedString.Key.foregroundColor: UIColor.systemIndigo]
        
        UITabBarItem
            .appearance()
            .setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .bold).rounded()],
                                    for: .normal)
    }
    
    var body: some View {
        TabView(selection: $selection) {
            GameView()
                .tabItem {
                    selection == 0 ?
                    Image(systemName: "rectangle.grid.2x2.fill")
                        .environment(\.symbolVariants, .none) :
                    Image(systemName: "rectangle.grid.2x2")
                        .environment(\.symbolVariants, .none)
                    
                    Text("Game")
                }
                .tag(0)
            
            StatsView()
                .tabItem {
                    selection == 1 ?
                    Image(systemName: "chart.bar.fill")
                        .environment(\.symbolVariants, .none) :
                    Image(systemName: "chart.bar")
                        .environment(\.symbolVariants, .none)
                    
                    Text("Stats")
                }
                .tag(1)
        }
    }
}

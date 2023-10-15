//
//  StatsView.swift
//  HueHunt
//
//  Created by Ярослав on 15.10.2023.
//

import SwiftUI

struct StatsView: View {
    var body: some View {
        NavigationStack {
            List {
                
            }
            .padding(Config.padding)
            .navigationTitle("Stats")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
    }
}
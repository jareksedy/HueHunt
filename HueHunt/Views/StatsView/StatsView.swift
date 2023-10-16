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
                Section {
                    Text("Item 1")
                }.listRowBackground(Color.accentColor.opacity(0.05))
                
                Section {
                    Text("Item 2")
                    Text("Item 3")
                    Text("Item 4")
                }
                .listRowBackground(Color.accentColor.opacity(0.05))
                
                Section {
                    Text("Item 5")
                    Text("Item 6")
                    Text("Item 7")
                }.listRowBackground(Color.accentColor.opacity(0.05))
            }
            .scrollContentBackground(.hidden)
            .navigationTitle("Statistics")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

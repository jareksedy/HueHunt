//
//  GameViewModel.swift
//  HueHunt
//
//  Created by Ярослав on 13.10.2023.
//

import SwiftUI

enum GameDifficulty: Int {
    case easy = 0
    case medium = 1
    case hard = 2
}

class GameViewModel: ObservableObject {
    @Published var columns = Array(repeating: GridItem(.flexible(minimum: 5), spacing: Config.spacing), count: Config.columns)
    @Published var difficulty: GameDifficulty = .easy
    @Published var colors: [Color] = []
    @Published var marks: [MarkType] = Array(repeating: .none, count: Config.cells)
    
    @Published var health: Int = 3
    @Published var round: Int = 0
    
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Published var startDate = Date.now
    
    private var randomIndices = (0, 0)
    
    init() {
        generateColors()
    }
    
    func isCorrect(_ index: Int) -> Bool {
        colors.filter { $0 == colors[index] }.count > 1
    }
    
    func generateColors(difficulty: GameDifficulty = .easy) {
        round += 1
        randomIndices = (0, 0)
        marks = Array(repeating: .none, count: Config.cells)
        
        var colorSet = Set<Color>()
        let colorRange: ClosedRange<Double>
        
        switch difficulty {
        case .easy: colorRange = 0.1...0.9 // Wide range, very different colors
        case .medium: colorRange = 0.2...0.8 // Medium range, more similar colors
        case .hard: colorRange = 0.4...0.6 // Narrow range, very similar colors
        }
        
        while colorSet.count < Config.cells {
            let tempColor = Color.random(in: colorRange)
            colorSet.insert(tempColor)
        }
        
        while randomIndices.0 == randomIndices.1 {
            randomIndices.0 = .random(in: 0...Config.cells - 1)
            randomIndices.1 = .random(in: 0...Config.cells - 1)
        }
        
        colors = Array(colorSet).shuffled()
        colors[randomIndices.0] = colors[randomIndices.1]
    }
    
    func handleUserInput(_ index: Int) {
        guard marks[index] == .none else { return }
        
        if isCorrect(index) {
            Haptics.shared.play(.rigid)
            showCorrectColors()
            restartRound()
        } else {
            marks[index] = .xmark
            health -= 1
            if health > 0 { Haptics.shared.play(.heavy) }
        }
        
        if health <= 0 {
            Haptics.shared.notify(.error)
            showCorrectColors()
            restartRound(restartGame: true)
        }
    }
    
    private func showCorrectColors() {
        marks[randomIndices.0] = .checkmark
        marks[randomIndices.1] = .checkmark
    }
    
    private func restartRound(restartGame: Bool = false) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.smooth(duration: 1)) {
                self.generateColors()
                
                if restartGame {
                    self.health = 3
                    self.round = 1
                    self.startDate = Date.now
                }
            }
        }
    }
}

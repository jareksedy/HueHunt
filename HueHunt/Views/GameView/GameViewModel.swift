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
    @Published var columns = Array(repeating: GridItem(.flexible(minimum: 75),
                                                       spacing: Config.spacing), count: Config.columns)
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
        
        let baseColor = Color(red: .random(in: 0...0.01), green: .random(in: 0...0.01), blue: .random(in: 0...0.01))
        var colorSet = Set<Color>()
        var step = 0.0
        var stepValue: CGFloat {
            switch difficulty {
            case .easy: return 0.04
            case .medium: return 0.03
            case .hard: return 0.02
            }
        }
        
        while colorSet.count < Config.cells {
            let tempColor = Color(red: baseColor.components.red + step + .random(in: 0...0.3),
                                  green: baseColor.components.green + step + .random(in: 0...0.3),
                                  blue: baseColor.components.blue + step + .random(in: 0...0.3)
            )
            
            step += stepValue
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

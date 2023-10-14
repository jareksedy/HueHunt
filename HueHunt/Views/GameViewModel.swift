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
    @Published var columns = Array(repeating: GridItem(.fixed(75), spacing: 2), count: 4)
    @Published var difficulty: GameDifficulty = .easy
    @Published var colors: [Color] = []
    @Published var marks: [MarkType] = Array(repeating: .none, count: 16)

    private var randomIndices = (0, 0)
    
    init() {
        generateColors()
    }
    
    func isCorrect(_ index: Int) -> Bool {
        colors.filter { $0 == colors[index] }.count > 1
    }
    
    func generateColors(difficulty: GameDifficulty = .easy) {
        randomIndices = (0, 0)
        marks = Array(repeating: .none, count: 16)
        
        let baseColor = Color(red: .random(in: 0...0.05), green: .random(in: 0...0.05), blue: .random(in: 0...0.05))
        var colorSet = Set<Color>()
        var step = 0.0
        var stepValue: CGFloat {
            switch difficulty {
            case .easy: return 0.04
            case .medium: return 0.03
            case .hard: return 0.02
            }
        }
        
        while colorSet.count < 16 {
            let tempColor = Color(red: baseColor.components.red + step + .random(in: 0...0.4),
                                  green: baseColor.components.green + step + .random(in: 0...0.4),
                                  blue: baseColor.components.blue + step + .random(in: 0...0.4)
            )
            
            step += stepValue
            colorSet.insert(tempColor)
        }
        
        while randomIndices.0 == randomIndices.1 {
            randomIndices.0 = .random(in: 0...15)
            randomIndices.1 = .random(in: 0...15)
        }
        
        colors = Array(colorSet)
        colors[randomIndices.0] = colors[randomIndices.1]
    }
    
    func handleUserInput(_ index: Int) {
        marks[randomIndices.0] = .checkmark
        marks[randomIndices.1] = .checkmark
        
        if !isCorrect(index) {
            marks[index] = .xmark
        }
        
        //if isCorrect(index) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                withAnimation(.smooth(duration: 1)) {
                    self.generateColors()
                }
            }
        //}
    }
}

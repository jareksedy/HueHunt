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
    @Published var correctGuess: Bool = false
    
    private var correctIndices = (0, 0)
    
    init() {
        generateColors()
    }
    
    func isCorrect(_ index: Int) -> Bool {
        index == correctIndices.0 || index == correctIndices.1
    }
    
    func generateColors(difficulty: GameDifficulty = .easy) {
        let baseColor = Color(red: .random(in: 0...0.2), green: .random(in: 0...0.2), blue: .random(in: 0...0.2))
        var colorSet = Set<Color>()
        var step = 0.0
        var randomIndices = (0, 0)
        var stepValue: CGFloat {
            switch difficulty {
            case .easy: return 0.04
            case .medium: return 0.03
            case .hard: return 0.01
            }
        }
        
        while colorSet.count < 16 {
            let tempColor = Color(red: baseColor.components.red + step + CGFloat.random(in: 0...0.1),
                                  green: baseColor.components.green + step + CGFloat.random(in: 0...0.1),
                                  blue: baseColor.components.blue + step + CGFloat.random(in: 0...0.1)
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
        correctIndices = randomIndices
        correctGuess = false
    }
    
    func handleUserInput(_ index: Int) {
        correctGuess = (index == correctIndices.0 || index == correctIndices.1)
        
        print(correctIndices)
        if index == correctIndices.0 || index == correctIndices.1 {
            print("YES!")
        } else {
            print("NO!")
        }
    }
}

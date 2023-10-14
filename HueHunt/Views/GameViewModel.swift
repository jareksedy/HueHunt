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
    @Published var selectedIndex: Int? = nil
    
    private var correctIndices: [Int] = []
    
    init() {
        generateColors()
    }
    
    func isCorrect(_ index: Int) -> Bool {
        colors.filter { $0 == colors[index] }.count > 1
    }
    
    func generateColors(difficulty: GameDifficulty = .easy) {
        selectedIndex = nil
        correctIndices = []
        
        let baseColor = Color(red: .random(in: 0...0.1), green: .random(in: 0...0.1), blue: .random(in: 0...0.1))
        var colorSet = Set<Color>()
        var step = 0.0
        var randomIndices = (0, 0)
        var stepValue: CGFloat {
            switch difficulty {
            case .easy: return 0.05
            case .medium: return 0.04
            case .hard: return 0.01
            }
        }
        
        while colorSet.count < 16 {
            let tempColor = Color(red: baseColor.components.red + step,
                                  green: baseColor.components.green + step,
                                  blue: baseColor.components.blue + step
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
        
        correctIndices.append(randomIndices.0)
        correctIndices.append(randomIndices.1)
    }
    
    func mark(for index: Int) -> CheckmarkType {
        guard let selectedIndex, selectedIndex == index else { return .none }
        
        if isCorrect(selectedIndex) {
            return .checkmark
        }
        
        return .xmark
    }
    
    func handleUserInput(_ index: Int) {
        selectedIndex = index
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
            withAnimation(.smooth(duration: 0.75)) {
                self.generateColors()
            }
        }
    }
}

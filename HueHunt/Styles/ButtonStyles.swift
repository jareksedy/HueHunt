//
//  ButtonStyles.swift
//  HueHunt
//
//  Created by Yaroslav Sedyshev on 14.10.2023.
//

import SwiftUI

struct ColorButtonStyle: ButtonStyle {
    var color: Color
    var mark: CheckmarkType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 75, height: 75)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: configuration.isPressed ? 24 : 12))
            .scaleEffect(configuration.isPressed ? 0.75 : 1)
            .overlay(mark == .checkmark ? Image(systemName: "checkmark")
                .resizable()
                .foregroundColor(.white)
                .transition(.scale)
                .frame(width: 25, height: 25) : nil)
            .overlay(mark == .xmark ? Image(systemName: "xmark")
                .resizable()
                .foregroundColor(.white)
                .transition(.scale)
                .frame(width: 25, height: 25) : nil)
            
    }
}

enum CheckmarkType: String {
    case none
    case checkmark
    case xmark
}

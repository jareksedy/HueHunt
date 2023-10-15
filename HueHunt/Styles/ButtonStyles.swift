//
//  ButtonStyles.swift
//  HueHunt
//
//  Created by Yaroslav Sedyshev on 14.10.2023.
//

import SwiftUI

struct ColorButtonStyle: ButtonStyle {
    var color: Color
    var mark: MarkType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaledToFill()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .aspectRatio(1, contentMode: .fill)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: configuration.isPressed ? 24 : 12))
            //.id(UUID())
            //.transition(.scale(scale: 0.5).combined(with: .opacity))
            .scaleEffect(configuration.isPressed ? 0.75 : 1)
            .overlay(mark == .checkmark ? Image(systemName: "checkmark").markOverlay() : nil)
            .overlay(mark == .xmark ? Image(systemName: "xmark").markOverlay() : nil)
        
    }
}

enum MarkType: String {
    case none
    case checkmark
    case xmark
}

extension Image {
    func markOverlay() -> some View {
        self
            .resizable()
            .foregroundColor(.white)
            .transition(.scale.combined(with: .push(from: Bool.random() ? .top : .bottom)).combined(with: .opacity))
            .fontWeight(.medium)
            .frame(width: 35, height: 35)
    }
}

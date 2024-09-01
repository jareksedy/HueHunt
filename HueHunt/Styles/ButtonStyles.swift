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
            .clipShape(RoundedRectangle(cornerRadius: Config.cornerRadius))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .overlay(markOverlay(for: mark))
    }
    
    @ViewBuilder
    private func markOverlay(for mark: MarkType) -> some View {
        GeometryReader { geometry in
            ZStack {
                if mark == .checkmark {
                    Image(systemName: "checkmark")
                        .markOverlay(size: geometry.size)
                } else if mark == .xmark {
                    Image(systemName: "xmark")
                        .markOverlay(size: geometry.size)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
        }
    }
}

enum MarkType: String {
    case none
    case checkmark
    case xmark
}

extension Image {
    func markOverlay(size: CGSize) -> some View {
        self
            .resizable()
            .foregroundColor(.indigoLight)
            .transition(.scale.combined(with: .opacity))
            .fontWeight(.bold)
            .frame(width: size.width * 0.25, height: size.width * 0.25)
    }
}

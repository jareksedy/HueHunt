//
//  Color+Components.swift
//  HueHunt
//
//  Created by Yaroslav Sedyshev on 13.10.2023.
//

import SwiftUI

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        
        guard UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            return (0, 0, 0, 0)
        }
        
        return (r, g, b, a)
    }
}

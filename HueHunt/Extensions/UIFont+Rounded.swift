//
//  UIFont+Rounded.swift
//  HueHunt
//
//  Created by Ярослав on 15.10.2023.
//

import SwiftUI

extension UIFont {
    func rounded() -> UIFont {
        guard let descriptor = fontDescriptor.withDesign(.rounded) else {
            return self
        }

        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

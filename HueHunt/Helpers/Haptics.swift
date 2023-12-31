//
//  Haptics.swift
//  HueHunt
//
//  Created by Ярослав on 18.10.2023.
//

import SwiftUI

class Haptics {
    static let shared = Haptics()
    
    private init() {}

    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }
    
    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

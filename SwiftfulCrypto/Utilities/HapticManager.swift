//
//  HapticManager.swift
//  SwiftfulCrypto
//
//  Created by Giorgi Meqvabishvili on 14.04.23.
//

import Foundation
import SwiftUI

class HapticManager {
    static  private let generator =  UINotificationFeedbackGenerator()
    
    static func notifacation(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

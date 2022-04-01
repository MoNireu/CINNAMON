//
//  FeedBackUtil.swift
//  Cinnamon
//
//  Created by MoNireu on 2022/04/01.
//

import Foundation
import UIKit


class FeedBackUtil {
    static let shared = FeedBackUtil()
    private init() {}
    
    private var feedBackGenerator: UINotificationFeedbackGenerator?
    
    func prepareFeedBackGenerator() {
        feedBackGenerator = UINotificationFeedbackGenerator()
        feedBackGenerator?.prepare()
    }
    
    func releaseFeedBackGenerator() {
        feedBackGenerator = nil
    }
    
    func haptic(notificationType: UINotificationFeedbackGenerator.FeedbackType) {
        if feedBackGenerator != nil {
            prepareFeedBackGenerator()
        }
        feedBackGenerator?.notificationOccurred(notificationType)
    }
}

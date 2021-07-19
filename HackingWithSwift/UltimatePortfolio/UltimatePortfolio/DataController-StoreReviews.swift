//
//  DataController-StoreReviews.swift
//  DataController-StoreReviews
//
//  Created by Andrei Chenchik on 19/7/21.
//

import Foundation
import StoreKit

extension DataController {
    func appLaunched() {
        guard count(for: Project.fetchRequest()) >= 5 else { return }

        let allScenes = UIApplication.shared.connectedScenes
        let scene = allScenes.first { $0.activationState == .foregroundActive }

        if let windowScene = scene as? UIWindowScene {
            SKStoreReviewController.requestReview(in: windowScene)
        }
    }
}

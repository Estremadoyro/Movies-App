//
//  HapticManager.swift
//  MoviesApp
//
//  Created by Leonardo on 9/21/24.
//

import UIKit

final class HapticManager {
    private var generator: UIFeedbackGenerator?

    private var notificationFeedbackType: UINotificationFeedbackGenerator.FeedbackType?

    static let shared = HapticManager()

    private init() {}
}

// MARK: - API
extension HapticManager {
    func prepare(_ generatorType: Generator) {
        prepareGenerator(generatorType)
    }

    func trigger(autoRelease: Bool = true) {
        triggerHaptic(autoRelease: autoRelease)
    }

    static func runSuccess() {
        shared.prepare(.notification(feedback: .success))
        shared.trigger()
    }

    static func runSelection() {
        shared.prepare(.selection)
        shared.trigger()
    }

    static func runLight() {
        shared.prepare(.impact(style: .light))
        shared.trigger()
    }
}

// MARK: - Generate
private extension HapticManager {
    func prepareGenerator(_ generatorType: Generator) {
        switch generatorType {
        case .impact(let style):
            impact(style: style)
        case .selection:
            selection()
        case .notification(let feedback):
            notification(feedback: feedback)
        }
        generator?.prepare()
    }

    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        generator = UIImpactFeedbackGenerator(style: style)
    }

    func selection() {
        generator = UISelectionFeedbackGenerator()
    }

    func notification(feedback: UINotificationFeedbackGenerator.FeedbackType) {
        notificationFeedbackType = feedback
        generator = UINotificationFeedbackGenerator()
    }
}

// MARK: - Trigger
private extension HapticManager {
    func triggerHaptic(autoRelease: Bool) {
        defer { notificationFeedbackType = nil }

        switch generator {
        case (let generator) as UIImpactFeedbackGenerator:
            generator.impactOccurred()
        case (let generator) as UISelectionFeedbackGenerator:
            generator.selectionChanged()
        case (let generator) as UINotificationFeedbackGenerator:
            guard let notificationFeedbackType else { return }
            generator.notificationOccurred(notificationFeedbackType)
        default:
            break
        }

        guard autoRelease else { return }
        generator = nil
    }
}

// MARK: - Generator types
extension HapticManager {
    enum Generator {
        case impact(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium)
        case selection
        case notification(feedback: UINotificationFeedbackGenerator.FeedbackType)
    }
}

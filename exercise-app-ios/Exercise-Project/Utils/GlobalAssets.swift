//
//  GlobalAssets.swift
//  Exercise-Project
//
//  Created by Inagamjanov on 30/10/24.
//

import SwiftUI


// MARK: Custom Haptic
func Haptic(haptic_type: UINotificationFeedbackGenerator.FeedbackType = .success) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(haptic_type)
}


// MARK: - All regions generate when App launch
var all_region: Array<Country> = get_regions()


// MARK: Custom images for alert
let copy = UIImage.init(systemName: "doc.on.doc.fill")!.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
let xmark = UIImage.init(systemName: "xmark.circle.fill")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
let update = UIImage.init(systemName: "arrow.turn.left.up")!.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
let checkmark = UIImage(systemName: "checkmark.circle.fill")!.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
let checkmark_green = UIImage.init(systemName: "checkmark.circle.fill")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
let triangle_yellow = UIImage.init(systemName: "exclamationmark.triangle.fill")!.withTintColor(.systemYellow, renderingMode: .alwaysOriginal)

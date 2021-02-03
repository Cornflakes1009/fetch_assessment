//
//  extensions.swift
//  Assessment
//
//  Created by HaroldDavidson on 1/30/21.
//

import UIKit
import AVFoundation

// MARK: - Make Image View support images from URL
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

// MARK: - Vibrations
extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

// MARK: Adding a Light Vibration
/** Light Haptic Feedback for button taps
 # For other vibrations, see: #
    https://www.hackingwithswift.com/example-code/uikit/how-to-generate-haptic-feedback-with-uifeedbackgenerator
 */
func vibrate() {
    let generator = UIImpactFeedbackGenerator(style: .light)
    generator.impactOccurred()
}

// making every button tap vibrate
extension UIButton {
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        vibrate()
    }
}

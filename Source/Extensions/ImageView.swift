//
//  ImageView.swift
//  NewsKit-iOS-App
//
//  Created by Олег on 24.09.2019.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    func blur(withStyle style: UIBlurEffect.Style = .light) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        addSubview(blurEffectView)
        clipsToBounds = true
    }
}

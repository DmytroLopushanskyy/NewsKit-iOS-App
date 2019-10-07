//
//  DarkModeAdaptation.swift
//  NewsKit-iOS-App
//
//  Created by Дмитро Лопушанський on 10/6/19.
//  Copyright © 2019 OlehTyzhai. All rights reserved.
//

import UIKit


@available(iOS 13.0, *)
let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case
    .unspecified,
    .light: return .white
    case .dark: return .black
    @unknown default:
        return .white
    }
}

@available(iOS 13.0, *)
let dynamicColorReversed = UIColor { (traitCollection: UITraitCollection) -> UIColor in
    switch traitCollection.userInterfaceStyle {
    case
    .unspecified,
    .light: return .black
    case .dark: return .white
    @unknown default:
        return .black
    }
}



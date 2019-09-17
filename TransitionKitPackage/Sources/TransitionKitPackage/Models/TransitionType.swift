//
//  TransitionSettings.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import Foundation

// This enum will inform the animation controller which animation class was selected based on the option that the user selected

public enum TransitionType: String, CaseIterable {
    case fade = "Fade"
    case slide = "Slide"
    case slideFade = "Slide & Fade"
    case flip = "Flip"
    case story = "Story"
}

public enum TransitionMoviment{
    case left
    case right
}

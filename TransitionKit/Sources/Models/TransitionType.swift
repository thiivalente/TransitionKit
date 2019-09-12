//
//  TransitionSettings.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import Foundation

// This enum will inform the animation controller which animation class was selected based on the option that the user selected

public enum TransitionType {
    case fade
    case slide
    case slideFade
    case flip
    case story

    // This init is optionional, but recommended to select the option based on the tag of UISwitch
    public init?(rawValue: Int){
        switch rawValue {
        case 0:
            self = .fade
        case 1:
            self = .slide
        case 2:
            self = .slideFade
        case 3:
            self = .flip
        case 4:
            self = .story
            
        default:
            return nil
        }
    }
}

public enum TransitionMoviment{
    case left
    case right
}

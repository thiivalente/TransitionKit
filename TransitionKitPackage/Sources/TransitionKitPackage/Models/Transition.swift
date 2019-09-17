//
//  Transition.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import UIKit

public class Transition{
    
    private var type: TransitionType
    private var time: Double = 0.5

    /// Needed to use the framework.
    ///
    /// - Parameters:
    ///   - type: Choose your transition
    ///   - time: Choose the time of transition
    public init(type: TransitionType, time: Double = 0.5) {
        self.type = type
        self.time = time
    }

    /// This function can change the time after the initialize
    ///
    /// - Parameter time: Double
    public func change(time: Double) {
        self.time = time
    }

    /// If you want to use multiple transitions
    ///
    /// - Parameter type: Choose the new transtion
    public func change(type: TransitionType) {
        self.type = type
    }

    /// The transition selected will be return the effect in this call
    ///
    /// - Parameter side: Choose your side transition effect
    /// - Returns: Return the effect of transtion
    public func run(side: TransitionMoviment = .left) -> UIViewControllerAnimatedTransitioning {
        switch type {
        case .fade:
            return FadeAnimationController()
        case .slide:
            return SlideAnimationController(presenting: side)
        case .slideFade:
            return FadeSlideAnimationController(presenting: side)
        case .flip:
            return FlipAnimationController(presenting: side)
        case .story:
            return StoryAnimationController(presenting: side)
        }
    }
}


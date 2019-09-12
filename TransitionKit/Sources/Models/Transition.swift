//
//  Transition.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import UIKit

public class Transition{
    
    private var typeTransition: TransitionType
    private var transitionTime: Double = 0.5

    /// Needed to use the framework.
    ///
    /// - Parameters:
    ///   - typeTransition: Choose your transition
    ///   - transitionTime: Choose the time of transition
    public init(typeTransition: TransitionType,transitionTime: Double? = nil) {
        self.typeTransition = typeTransition
        self.transitionTime = (transitionTime == nil) ? 0.5 : transitionTime!
    }

    /// This function can change the time after the initialize
    ///
    /// - Parameter time: Double
    public func changeTime(time: Double) {
        self.transitionTime = time
    }

    /// If you want to use multiple transitions
    ///
    /// - Parameter typeTransition: Choose the new transtion
    public func changeType(typeTransition: TransitionType) {
        self.typeTransition = typeTransition
    }

    /// The transition selected will be return the effect in this call
    ///
    /// - Parameter side: Choose your side transition effect
    /// - Returns: Return the effect of transtion
    public func runTransition(side: TransitionMoviment) -> UIViewControllerAnimatedTransitioning {
        switch self.typeTransition {
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


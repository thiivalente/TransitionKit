//
//  FadeAnimationController.swift
//  FluidInterfaces
//
//  Created by Ada 2018 on 24/07/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class FadeAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let presenting: Bool
    private var timeInMilliseconds: Double

    override init() {
        self.presenting = true
        self.timeInMilliseconds = 0.5
    }
    
    //Time of animation if isn't interactive ( gesture ... )
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.timeInMilliseconds
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        //
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        
        //
        let container = transitionContext.containerView
        if presenting {
            container.addSubview(toView)
            toView.alpha = 0.0
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            //
            if self.presenting {
                toView.alpha = 1.0
            } else {
                fromView.alpha = 0.0
            }
        }) { _ in
            //
            let success = !transitionContext.transitionWasCancelled
            if !success {
                toView.removeFromSuperview()
            }
            transitionContext.completeTransition(success)
        }
    }
    
}

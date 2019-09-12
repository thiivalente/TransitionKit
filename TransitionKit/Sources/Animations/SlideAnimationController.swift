//
//  SlideAnimationController.swift
//  FluidInterfaces
//
//  Created by Ada 2018 on 26/07/2018.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import UIKit

class SlideAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    let sideMoviment: TransitionMoviment
    private var timeInMilliseconds: Double
    
    init(presenting: TransitionMoviment) {
        self.sideMoviment = presenting
        self.timeInMilliseconds = 0.5
    }
    
    
    // Will give the trasition time
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.timeInMilliseconds
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else {
            return
        }
        
        guard let toView = transitionContext.view(forKey: .to) else {
            return
        }
        
        let containerView = transitionContext.containerView
        
        var toViewStartKeyframe: CGRect
        var fromViewEndKeyframe: CGRect
        
        switch sideMoviment {
        case .right:
            toViewStartKeyframe = CGRect(origin: CGPoint(x: containerView.frame.width, y: 0), size: containerView.frame.size)
            fromViewEndKeyframe = CGRect(origin: CGPoint(x: -containerView.frame.width, y: 0), size: containerView.frame.size)
        case .left:
            toViewStartKeyframe = CGRect(origin: CGPoint(x: -containerView.frame.width, y: 0), size: containerView.frame.size)
            fromViewEndKeyframe = CGRect(origin: CGPoint(x: containerView.frame.width, y: 0), size: containerView.frame.size)
        }
        
        containerView.addSubview(fromView)
        containerView.addSubview(toView)
        
        toView.frame = toViewStartKeyframe
        
        UIView.animate(withDuration: self.timeInMilliseconds, animations: {
            
            fromView.frame = fromViewEndKeyframe
            toView.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: toView.frame.size)
            
        }) { (isComplete) in
            transitionContext.completeTransition(isComplete)
        }
    }
}

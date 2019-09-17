//
//  CubeAnimationController.swift
//  SwiftTransitions
//
//  Created by Philipp Kuecuekyan on 7/11/14.
//  Copyright (c) 2014 phi & co. All rights reserved.
// https://github.com/pkuecuekyan/SwiftTransitions/blob/master/SwiftTransitions/SwiftTransitions/CubeAnimationController.swift

import UIKit

class StoryAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var timeInMilliseconds: Double
    let sideMoviment: TransitionMoviment
    
    init(presenting: TransitionMoviment) {
        self.sideMoviment = presenting
        self.timeInMilliseconds = 0.5
    }
    
    // Method to do animation
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Hold onto views, VCs, contexts, frames
        let containerView = transitionContext.containerView
        guard
            let fromViewController = transitionContext .viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext .viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromView = fromViewController.view,
            let toView = toViewController.view else {
                return
        }
        toView.frame = fromViewController.view.frame
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        // Create a transition background view
        let backgroundView = UIView(frame: transitionContext.initialFrame(for: fromViewController))
        backgroundView.backgroundColor = UIColor.black
        
        containerView.addSubview(backgroundView)
        
        // Take a snapshot of the presenting view
        let fromSnapshotRect = fromView.bounds
        guard let fromSnapshotView = fromView.resizableSnapshotView(from: fromSnapshotRect, afterScreenUpdates: false, withCapInsets: UIEdgeInsets.zero) else {
            return
        }
        fromSnapshotView.layer.anchorPointZ = -((fromSnapshotView.frame.size.width) / 2)
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = -1.0 / 1000
        transform = CATransform3DTranslate(transform, 0, 0, (fromSnapshotView.layer.anchorPointZ))
        fromSnapshotView.layer.transform = transform
        fromSnapshotView.layer.borderColor = UIColor.black.cgColor
        fromSnapshotView.layer.borderWidth = 2.0
        
        backgroundView.addSubview(fromSnapshotView)
        
        // Take a snapshot of the presented view
        let toSnapshotRect = toView.bounds
        guard let toSnapshotView = toView.resizableSnapshotView(from: toSnapshotRect, afterScreenUpdates: true, withCapInsets: UIEdgeInsets.zero) else {
            return
        }
        toSnapshotView.layer.anchorPointZ = -((toSnapshotView.frame.size.width) / 2)
        transform = CATransform3DIdentity
        transform.m34 = -1.0 / 1000
        transform = CATransform3DTranslate(transform, 0, 0, (toSnapshotView.layer.anchorPointZ))
        toSnapshotView.layer.transform = transform
        
        backgroundView.insertSubview(toSnapshotView, belowSubview:fromSnapshotView)
        
        switch sideMoviment {
        case .left:
            toSnapshotView.layer.transform = CATransform3DRotate((toSnapshotView.layer.transform), CGFloat(-Double.pi/2), 0, 1, 0)
        case .right:
            toSnapshotView.layer.transform = CATransform3DRotate((toSnapshotView.layer.transform), CGFloat(Double.pi / 2), 0, 1, 0)
        }
        
        UIView.animate(withDuration: self.timeInMilliseconds, delay: 0.0, options: UIView.AnimationOptions(), animations: {
            switch self.sideMoviment {
            case .left:
                toSnapshotView.layer.transform = CATransform3DRotate((toSnapshotView.layer.transform), CGFloat(Double.pi / 2), 0, 1, 0)
                fromSnapshotView.layer.transform = CATransform3DRotate((fromSnapshotView.layer.transform), CGFloat(Double.pi / 2), 0, 1, 0)
            case .right:
                toSnapshotView.layer.transform = CATransform3DRotate((toSnapshotView.layer.transform), CGFloat(-Double.pi / 2), 0, 1, 0)
                fromSnapshotView.layer.transform = CATransform3DRotate((fromSnapshotView.layer.transform), CGFloat(-Double.pi / 2), 0, 1, 0)
            }
            
        }, completion: {(value: Bool) in
            fromSnapshotView.removeFromSuperview()
            toSnapshotView.removeFromSuperview()
            backgroundView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
        
    }
    
    //Time of animation if isn't interactive ( gesture ... )
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.timeInMilliseconds
    }
}

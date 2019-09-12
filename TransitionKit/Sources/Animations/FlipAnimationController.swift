//  SwipeAnimationController.swift
//  CustomTransitionTutorial
//
//  Created by Ada 2018 on 26/07/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
// https://github.com/jonhpol/CustomTransitionTutorial
import UIKit

class FlipAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    
    private var timeInMilliseconds: Double
    let sideMoviment: TransitionMoviment
    
    init(presenting: TransitionMoviment) {
        self.sideMoviment = presenting
        self.timeInMilliseconds = 0.5
    }
    
    // Method to do animation
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView   = transitionContext.containerView
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to),
            let fromView = fromViewController.view,
            let toView = toViewController.view else {
                return
        }
        toView.frame = fromViewController.view.frame
        containerView.insertSubview(toView, belowSubview: fromView)
        
        // Create a background view
        let backgroundView = UIView(frame: transitionContext.initialFrame(for: fromViewController))
        backgroundView.backgroundColor = UIColor.black
        
        containerView.addSubview(backgroundView)
        
        // Take a snapshot(print) from presenting view and presented view
        let fromSnapshotRect = fromView.bounds
        let toSnapshotRect = toView.bounds
        guard
            let fromSnapshotView = fromView.resizableSnapshotView(from: fromSnapshotRect, afterScreenUpdates: false, withCapInsets: .zero),
            let toSnapshotView = toView.resizableSnapshotView(from: toSnapshotRect, afterScreenUpdates: true, withCapInsets: .zero) else {
                return
        }
        
        backgroundView.addSubview(fromSnapshotView)
        backgroundView.insertSubview(toSnapshotView, belowSubview: fromSnapshotView)
        
        
        // Function to calculate the flips of the rotation 3D
        func flipTransform(angle: CGFloat, offset: CGFloat = 0) -> CATransform3D {
            var transform = CATransform3DMakeTranslation(offset, 0, 0)
            transform.m34 = -1.0 / 400
            transform = CATransform3DRotate(transform, angle, 0, 1, 0)
            return transform
        }
    
        // Variables to storage the states (keyframes) from animations.
        let transformFromStart:  CATransform3D
        let transformFromEnd:    CATransform3D
        let transformFromMiddle: CATransform3D
        let transformToStart:    CATransform3D
        let transformToMiddle:   CATransform3D
        let transformToEnd:      CATransform3D
        
        // Calc to position type - Left / Right
        switch sideMoviment {
        case .right:
            transformFromStart  = flipTransform(angle: 0,        offset: containerView.bounds.size.width / 2)
            transformFromEnd    = flipTransform(angle: -.pi,     offset: containerView.bounds.size.width / 2)
            transformFromMiddle = flipTransform(angle: -.pi / 2)
            transformToStart    = flipTransform(angle: .pi,      offset: -containerView.bounds.size.width / 2)
            transformToMiddle   = flipTransform(angle: .pi / 2)
            transformToEnd      = flipTransform(angle: 0,        offset: -containerView.bounds.size.width / 2)

            toSnapshotView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
            fromSnapshotView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
            
        case .left:
            transformFromStart  = flipTransform(angle: 0,        offset: -containerView.bounds.size.width / 2)
            transformFromEnd    = flipTransform(angle: .pi,      offset: -containerView.bounds.size.width / 2)
            transformFromMiddle = flipTransform(angle: .pi / 2)
            transformToStart    = flipTransform(angle: -.pi,     offset: containerView.bounds.size.width / 2)
            transformToMiddle   = flipTransform(angle: -.pi / 2)
            transformToEnd      = flipTransform(angle: 0,        offset: containerView.bounds.size.width / 2)

            
            toSnapshotView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
            fromSnapshotView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
        }
        
        
        // Animaton of the states previous calculate.
        toSnapshotView.layer.transform = transformToStart
        fromSnapshotView.layer.transform = transformFromStart
        
        UIView.animateKeyframes(withDuration: self.transitionDuration(using: transitionContext), delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.0) {
                toSnapshotView.alpha = 0
                fromSnapshotView.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.5) {
                toSnapshotView.layer.transform = transformToMiddle
                fromSnapshotView.layer.transform = transformFromMiddle
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.0) {
                toSnapshotView.alpha = 1
                fromSnapshotView.alpha = 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                toSnapshotView.layer.transform = transformToEnd
                fromSnapshotView.layer.transform = transformFromEnd
            }
        }, completion: { finished in
            //Clear the transforms and the archorPoints of the views when the animation are finish
            fromSnapshotView.removeFromSuperview()
            toSnapshotView.removeFromSuperview()
            backgroundView.removeFromSuperview()
            
            // If the animation be not canceled, will finish the transition.
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    //Time of animation if isn't interactive ( gesture ... )
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.timeInMilliseconds
    }
}

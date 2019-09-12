//
//  ViewController.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import UIKit

class ViewController: ExampleController {
    override func setup() {
        title = "TrasitionKit Examples"
        self.navigationController?.delegate = self
    }
}

/// I've create a second viewController because the first is the root from navigation
/// Duplicate navigation root make impossible to set the navigation controller animation
class ViewController2: ExampleController {}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return Transition(typeTransition: .flip).runTransition(side: .right)
        } else {
            return Transition(typeTransition: .story).runTransition(side: .left)
        }
    }
}

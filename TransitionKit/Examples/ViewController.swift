//
//  ViewController.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import UIKit

class ViewController: ExampleController {
    
    var leftPickerView = UIPickerView()
    var rightPickerView = UIPickerView()
    
    override func setup() {
        view.backgroundColor = .white
        title = "TrasitionKit Examples"
        self.navigationController?.delegate = self
        leftPickerView.restorationIdentifier = "left"
        setPickerView(leftPickerView, side: .left)
        setPickerView(rightPickerView, side: .right)
    }
}

/// I've create a second viewController because the first is the root from navigation
/// Duplicate navigation root make impossible to set the navigation controller animation
class ViewController2: ExampleController {}

extension ViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        var type: TransitionType
        var typeInt: Int
        var side: TransitionMoviment
        
        if operation == .push {
            side = .right
            typeInt = Int(rightPickerView.selectedRow(inComponent: 0).description) ?? 0
        } else {
            side = .left
            typeInt = Int(leftPickerView.selectedRow(inComponent: 0).description) ?? 0
        }
        type = TransitionType.allCases[typeInt]
        return Transition(type: type).run(side: side)
    }
}

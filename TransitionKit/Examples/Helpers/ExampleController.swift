//
//  Test.swift
//  TransitionKit
//
//  Created by Thiago Valente on 12/09/19.
//  Copyright © 2019 Thiago Valente. All rights reserved.
//

import UIKit

class ExampleController: UIViewController {
    
    var button: UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .random
        setup()
        setup(with: button)
    }
    
    // This func exists to be override
    func setup() {
        
    }
    
    func setup(with button: UIButton) {
        button.setTitle("Press", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchUpInside)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 150),
            button.heightAnchor.constraint(equalToConstant: 150),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func buttonTapped(sender: UIButton) {
        navigationController?.pushViewController(ViewController2(), animated: true)
    }
    
}

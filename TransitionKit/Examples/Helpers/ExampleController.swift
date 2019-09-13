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
    
    func setPickerView(_ pickerView: UIPickerView, side: TransitionMoviment) {
        view.addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            pickerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            pickerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        if side == .left {
            NSLayoutConstraint.activate([
                pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            ])
        }
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
}

extension ExampleController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TransitionType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TransitionType.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.restorationIdentifier == "left" {
            title = TransitionType.allCases[row].rawValue
        } else {
            button.setTitle(TransitionType.allCases[row].rawValue, for: .normal)
        }
    }
    
}

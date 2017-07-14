//
//  CreateMessageViewController.swift
//  SecretMessage
//
//  Created by Jeff Ripke on 7/13/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit

protocol CreateMessageViewControllerDelegate: class {
    func createMessageViewControllerDidCreateMessage(text: String)
}

class CreateMessageViewController: UIViewController {
    
    var message: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secretMessageTextField.text = message
    }
    
    @IBOutlet weak var secretMessageLabel: UILabel!
    @IBOutlet weak var secretMessageTextField: UITextField!
    
    weak var delegate: CreateMessageViewControllerDelegate!
    
    @IBAction func createMessageButtonPressed() {
        delegate.createMessageViewControllerDidCreateMessage(text: secretMessageTextField.text!)
    }
}

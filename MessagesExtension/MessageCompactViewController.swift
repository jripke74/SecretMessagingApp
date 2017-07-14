//
//  MessageCompactViewController.swift
//  SecretMessage
//
//  Created by Jeff Ripke on 7/13/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit

protocol MessageCompactViewControllerDelegate: class {
    func didShowCreateMessage()
}

class MessageCompactViewController: UIViewController {
    
    weak var delegate: MessageCompactViewControllerDelegate!
    
    @IBAction func showCreateMessage() {
        self.delegate.didShowCreateMessage()
    }
}

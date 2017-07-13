//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Jeff Ripke on 7/13/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController {
    
    override func willBecomeActive(with conversation: MSConversation) {
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else {
            fatalError("No conversation found")
        }
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    func presentViewController(for conversion: MSConversation, for presentationStyle: MSMessagesAppPresentationStyle) {
        var controller: UIViewController!
        if presentationStyle == .compact {
            controller = instantiateMessagesCompactViewController()
        } else {
            controller = instantiateCreateMessagesCompactViewController()
        }
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        addChildViewController(controller)
        controller.view.frame = view.bounds
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.rightAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controller.didMove(toParentViewController: self)
    }
    
    private func instantiateMessagesCompactViewController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "MesageCompactViewController") as? MessageCompactViewController else {
            fatalError("MessagesCompactViewController")
        }
        return controller
    }
    
    private func instantiateCreateMessagesCompactViewController() -> UIViewController {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "CreateMessageViewController") as? CreateMessageViewController else {
            fatalError("CreateMessagesViewController")
        }
        return controller
    }
}

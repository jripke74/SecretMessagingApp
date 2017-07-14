//
//  MessagesViewController.swift
//  MessagesExtension
//
//  Created by Jeff Ripke on 7/13/17.
//  Copyright © 2017 Jeff Ripke. All rights reserved.
//

import UIKit
import Messages

class MessagesViewController: MSMessagesAppViewController, MessageCompactViewControllerDelegate, CreateMessageViewControllerDelegate {
    
    override func willBecomeActive(with conversation: MSConversation) {
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    override func willTransition(to presentationStyle: MSMessagesAppPresentationStyle) {
        guard let conversation = activeConversation else {
            fatalError("No conversation found")
        }
        presentViewController(for: conversation, for: presentationStyle)
    }
    
    func presentViewController(for conversation: MSConversation, for presentationStyle: MSMessagesAppPresentationStyle) {
        var controller: UIViewController!
        if presentationStyle == .compact {
            controller = instantiateMessagesCompactViewController()
        } else {
            if conversation.selectedMessage != nil {
                guard let message = conversation.selectedMessage,
                let url = message.url,
                let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
                let queryItem = components.queryItems?.first,
                let secretMessage = queryItem.value
                    else {
                        fatalError("JEFF: No message selected")
                }
                controller = instantiateCreateMessagesViewController(message: secretMessage)
                print(secretMessage)
            } else {
                controller = instantiateCreateMessagesViewController()
            }
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
        controller.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        controller.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        controller.didMove(toParentViewController: self)
    }
    
    func createMessageViewControllerDidCreateMessage(text: String) {
        requestPresentationStyle(.compact)
        var components = URLComponents()
        let queryItem = URLQueryItem(name: "secretMessage", value: text)
        components.queryItems = [queryItem]
        let layout = MSMessageTemplateLayout()
        layout.image = UIImage(named: "car")
        let message = MSMessage()
        message.layout = layout
        message.url = components.url!
        activeConversation?.insert(message, completionHandler: nil)
    }
    
    func didShowCreateMessage() {
        requestPresentationStyle(.expanded)
    }
    
    private func instantiateCreateMessagesViewController(message: String = "") -> UIViewController {
        guard let createMessageVC = storyboard?.instantiateViewController(withIdentifier: "CreateMessageViewController") as? CreateMessageViewController else {
            fatalError("JEFF: CreateMessagesViewController")
        }
        createMessageVC.delegate = self
        createMessageVC.message = message
        return createMessageVC
    }
    
    private func instantiateMessagesCompactViewController() -> UIViewController {
        guard let messageCompactVC = storyboard?.instantiateViewController(withIdentifier: "MessageCompactViewController") as? MessageCompactViewController else {
            fatalError("JEFF: MessagesCompactViewController")
        }
        messageCompactVC.delegate = self
        return messageCompactVC
    }
}

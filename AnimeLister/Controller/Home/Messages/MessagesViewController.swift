//
//  MessageViewController.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import MaterialComponents

class MessagesViewController: UIViewController {
    private let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = theme.titleBarColor
        return view
    }()
    
    private let messageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = theme.titleBarColor
        return view
    }()
    
    private let messageField: MDCTextField = {
        let field = MDCTextField()
        field.font = theme.textFont
        field.textColor = theme.textColor
        return field
    }()
    
    private let sendButton: MDCRaisedButton = {
        let button = MDCRaisedButton()
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        button.setTitle("Send", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    private var messagesTableView: UITableView = {
        let view = UITableView()
        
        return view
    }()
    
    private var conversation: Conversation!
    private var messageFieldController: MDCTextInputControllerOutlined!
    private var messageContainerBottom: NSLayoutConstraint!
    private let reuseID: String = "messageCell"
    
    init(conversation: Conversation) {
        self.conversation = conversation
        
        super.init(nibName: nil, bundle: nil)
        self.hidesKeyboardWhenTappedAround()
        self.view.backgroundColor = appTheme.backgroundColor
        self.title = currentUser.friends.contains(conversation.withUser) ? conversation.withUser.fullName : conversation.withUser.username
        
        setup()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        messageFieldController = MDCTextInputControllerOutlined(textInput: messageField)
        messageFieldController.activeColor = appTheme.buttonColor
        messageFieldController.floatingPlaceholderActiveColor = appTheme.placeHolderTextColor
        messageFieldController.inlinePlaceholderFont = appTheme.detailFont
        messageFieldController.normalColor = appTheme.placeHolderTextColor
        messageFieldController.placeholderText = "Send a message..."
        
        messageField.delegate = self
        
        messagesTableView.backgroundColor = .clear
        messagesTableView.dataSource = self
        messagesTableView.delegate = self
        messagesTableView.register(MessageCell.self, forCellReuseIdentifier: reuseID)
        messagesTableView.separatorStyle = .none
        messagesTableView.tableFooterView = UIView()
        
        messageContainerBottom = NSLayoutConstraint(
            item: messageContainerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view.safeAreaLayoutGuide,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    private func layoutView() {
        messageContainerView.anchor(
            to: view,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor)
        
        sendButton.anchor(
            to: messageContainerView,
            trailing: messageContainerView.trailingAnchor,
            centerY: messageContainerView.centerYAnchor,
            padding: .init(top: 5, left: 0, bottom: 5, right: 5),
            size: .init(width: 70, height: 0))
        
        messageField.anchor(
            to: messageContainerView,
            top: messageContainerView.topAnchor,
            leading: messageContainerView.leadingAnchor,
            trailing: sendButton.leadingAnchor,
            bottom: messageContainerView.bottomAnchor,
            padding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
        bottomView.anchor(
            to: view,
            top: messageField.bottomAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor)
        
        messagesTableView.anchor(
            to: view,
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: messageContainerView.topAnchor)
        
        view.addConstraint(messageContainerBottom)
    }
    
    @objc private func sendTapped() {
        
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            messageContainerBottom.constant -= (keyboardSize.height + 10)
            view.updateConstraintsIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        messageContainerBottom.constant = 0
        view.updateConstraintsIfNeeded()
    }
}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! MessageCell
        cell.message = conversation.messages[indexPath.row]
        cell.layoutSubviews()
        return cell
    }
}

extension MessagesViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        
        return true
    }
}

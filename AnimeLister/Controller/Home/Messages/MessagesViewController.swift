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
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return appTheme.statusBarStyle
    }
    
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
    
    private let messageField: ALTextField = {
        let field = ALTextField()
        
        return field
    }()
    
    private let sendButton: MDCRaisedButton = {
        let button = MDCRaisedButton()
        button.addTarget(self, action: #selector(sendTapped), for: .touchUpInside)
        button.backgroundColor = theme.buttonColor
        button.setTitle("Send", for: .normal)
        button.setTitleFont(theme.buttonFont, for: .normal)
        return button
    }()
    
    private var messagesTableView: UITableView = {
        let view = UITableView()
        return view
    }()
    
    private var conversation: Conversation
    private var page: Int = 1
    private var shouldFetchMore: Bool = false
    private var messageFieldController: MDCTextInputControllerOutlined!
    private var messageContainerBottom: NSLayoutConstraint!
    private let reuseID: String = "messageCell"
    
    init(conversation: Conversation) {
        self.conversation = conversation
        
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = appTheme.backgroundColor
        self.title = currentUser.friends.contains(conversation.withUser) ? conversation.withUser.fullName : conversation.withUser.username
        self.addKeyboardAdjustablility()
        self.hidesKeyboardWhenTappedAround()
        
        setup()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        fetchMessages()
    }
    
    private func setup() {
        messageFieldController = MDCTextInputControllerOutlined(textInput: messageField)
        messageFieldController.activeColor = appTheme.buttonColor
        messageFieldController.floatingPlaceholderActiveColor = appTheme.placeHolderTextColor
        messageFieldController.inlinePlaceholderFont = appTheme.detailFont
        messageFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
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
            padding: .init(top: 0, left: 0, bottom: 0, right: 5),
            size: .init(width: 80, height: 50))
        
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
    
    override func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            messageContainerBottom.constant -= (keyboardSize.height + 10)
            view.updateConstraintsIfNeeded()
        }
    }
    
    override func keyboardWillHide(_ notification: NSNotification) {
        messageContainerBottom.constant = 0
        view.updateConstraintsIfNeeded()
    }
}

extension MessagesViewController: UITableViewDataSource, UITableViewDelegate {
    private func fetchMessages() {
        let endpoint = MessagesEndPoint.messages(userID: conversation.withUser.id, page: page)
        NetworkRequest.router.request(endpoint) { (messages) in
            guard let messageList = messages as? MessageList else { return }
            if self.page == 1 {
                self.conversation.messages = messageList.messages
            } else {
                self.conversation.messages += messageList.messages
            }
            
            if self.page == messageList.lastPage {
                self.page = 1
                self.shouldFetchMore = false
            } else if self.page < messageList.lastPage {
                self.page += 1
                self.shouldFetchMore = true
            }
            
            DispatchQueue.main.async {
                self.messagesTableView.reloadData()
                self.view.setNeedsUpdateConstraints()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversation.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! MessageCell
        cell.message = conversation.messages[indexPath.row]
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && shouldFetchMore {
            fetchMessages()
        }
    }
}

extension MessagesViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        sendButton.isEnabled = textField.hasText == true ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text != "" else { return false }
        let endpoint = MessagesEndPoint.send(userID: conversation.withUser.id, message: text)
        NetworkRequest.router.request(endpoint) { (data) in
            self.page = 1
            self.shouldFetchMore = true
            self.fetchMessages()
        }
        
        return true
    }
}

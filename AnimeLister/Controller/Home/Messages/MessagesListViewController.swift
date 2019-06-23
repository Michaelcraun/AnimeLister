//
//  MessagesViewController.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class MessagesListViewController: UITableViewController {
    private let reuseID: String = "messagesUserCell"
    
    // MARK: - TEST DATA!!
    var user: User!
    var userList: [User] = []
    var messagesWithDeb: Conversation!
    var messagesWithBrett: Conversation!
    var messagesWithThomas: Conversation!
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTestData()
        setup()
    }
    
    private func configureTestData() {
        user = currentUser
        userList = [deborahCraun, brettChapin, thomasBunn]
        
        messagesWithDeb = Conversation(
            withUser: deborahCraun,
            messages: [
                Message(
                    fromUser: deborahCraun,
                    toUser: currentUser,
                    text: "Hey, there!?",
                    meta: MessageMeta(
                        liked: false,
                        status: "")),
                Message(
                    fromUser: deborahCraun,
                    toUser: currentUser,
                    text: "Michael?",
                    meta: MessageMeta(
                        liked: false,
                        status: "")),
                Message(
                    fromUser: deborahCraun,
                    toUser: currentUser,
                    text: "Are you ignoring me again!?",
                    meta: MessageMeta(
                        liked: false,
                        status: "")),
                Message(
                    fromUser: deborahCraun,
                    toUser: currentUser,
                    text: "Fine ASS!!",
                    meta: MessageMeta(
                        liked: false,
                        status: "sent"))])
        
        messagesWithBrett = Conversation(
            withUser: brettChapin,
            messages: [
                Message(
                    fromUser: currentUser,
                    toUser: brettChapin,
                    text: "Hey bubby.",
                    meta: MessageMeta(
                        liked: false,
                        status: "")),
                Message(
                    fromUser: brettChapin,
                    toUser: currentUser,
                    text: "Hey. How are you?",
                    meta: MessageMeta(
                        liked: false,
                        status: "")),
                Message(
                    fromUser: currentUser,
                    toUser: brettChapin,
                    text: "I'm good. Have you ever heard of an anime called Dragonball Z?",
                    meta: MessageMeta(
                        liked: true,
                        status: "")),
                Message(
                    fromUser: brettChapin,
                    toUser: currentUser,
                    text: "Heck yeah, I have! I love that one!",
                    meta: MessageMeta(
                        liked: true,
                        status: "read"))])
        
        messagesWithThomas = Conversation(
            withUser: thomasBunn,
            messages: [
                Message(
                    fromUser: thomasBunn,
                    toUser: currentUser,
                    text: "Hey there",
                    meta: MessageMeta(
                        liked: false,
                        status: "")),
                Message(
                    fromUser: currentUser,
                    toUser: thomasBunn,
                    text: "Hey, what's happening?",
                    meta: MessageMeta(
                        liked: false,
                        status: "sent"))])
    }
    
    private func setup() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl?.tintColor = appTheme.buttonColor
        
        tableView.backgroundColor = .clear
        tableView.register(MessagesUserCell.self, forCellReuseIdentifier: reuseID)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
    }
    
    private func listUsers(from refreshType: RefreshType) {
        
    }
    
    @objc private func refreshData() {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! MessagesUserCell
        cell.user = userList[indexPath.row]
        
        // MARK: - TEST DATA!!
        switch userList[indexPath.row] {
        case brettChapin: cell.messageList = messagesWithBrett
        case deborahCraun: cell.messageList = messagesWithDeb
        case thomasBunn: cell.messageList = messagesWithThomas
        default: break
        }
        // MARK: -
        
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var conversation: Conversation?
        
        switch userList[indexPath.row] {
        case brettChapin: conversation = messagesWithBrett
        case deborahCraun: conversation = messagesWithDeb
        case thomasBunn: conversation = messagesWithThomas
        default: break
        }
        
        guard let confirmedConvo = conversation else { return }
        let conversationVC = MessagesViewController(conversation: confirmedConvo)
        navigationController?.pushViewController(conversationVC, animated: true)
    }
}

//
//  MessagesListCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class MessagesUserCell: UITableViewCell, Themeable {
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let userImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = theme.buttonColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 22.25
        return view
    }()
    
    let readIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = theme.buttonColor
        view.isHidden = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = theme.subtitleFont
        label.textColor = theme.textColor
        return label
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = theme.detailFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    var user: User?
    
    // MARK: - Test Data!!
    var messageList: Conversation!
    // MARK: -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.fillTo(self)
        
        userImageView.anchor(
            to: containerView,
            leading: containerView.leadingAnchor,
            centerY: containerView.centerYAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 0),
            size: .init(width: 44.5, height: 44.5))
        
        readIndicator.anchor(
            to: containerView,
            trailing: containerView.trailingAnchor,
            centerY: containerView.centerYAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 10),
            size: .init(width: 20, height: 20))
        
        nameLabel.anchor(
            to: containerView,
            top: containerView.topAnchor,
            leading: userImageView.trailingAnchor,
            trailing: readIndicator.leadingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        messageLabel.anchor(
            to: containerView,
            top: nameLabel.bottomAnchor,
            leading: userImageView.trailingAnchor,
            trailing: readIndicator.leadingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 5, left: 10, bottom: 10, right: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let user = user else { return }
        nameLabel.text = currentUser.friends.contains(user) ? user.fullName : user.username
        
        guard let lastMessage = messageList.messages.last else {
            messageLabel.text = "Nothing to see here..."
            readIndicator.isHidden = true
            return
        }
        
        messageLabel.text = lastMessage.text
        readIndicator.isHidden = lastMessage.toUser == currentUser && lastMessage.meta.status != "read"
    }
}

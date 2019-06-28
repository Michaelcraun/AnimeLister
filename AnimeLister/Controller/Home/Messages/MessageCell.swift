//
//  MessageCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/20/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, Themeable {
    private let fromUserImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let toUserImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let messageContainerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = theme.textColor
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = theme.detailFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    private var messageLeading: NSLayoutConstraint!
    private var messageTrailing: NSLayoutConstraint!
    private var toUserImageWidth: NSLayoutConstraint!
    private var fromUserImageWidth: NSLayoutConstraint!
    var shouldShowMessageStatus: Bool = false
    var message: Message?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        messageContainerView.anchor(
            to: self,
            top: self.topAnchor,
            bottom: self.bottomAnchor,
            padding: .init(top: 5, left: 0, bottom: 5, right: 0))
        
        messageLabel.fillTo(
            messageContainerView,
            withPadding: .init(top: 5, left: 5, bottom: 5, right: 5))
        
//        statusLabel.anchor(
//            to: self,
//            top: messageContainerView.bottomAnchor,
//            trailing: messageContainerView.trailingAnchor,
//            bottom: self.bottomAnchor,
//            padding: .init(top: 5, left: 0, bottom: 0, right: 5))
        
        messageLeading = NSLayoutConstraint(
            item: messageContainerView,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 5.0)
        
        messageTrailing = NSLayoutConstraint(
            item: messageContainerView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: -5.0)
        
        self.addConstraints([messageLeading, messageTrailing])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let message = message else { return }
        messageLabel.text = message.text
        
        switch message.toUser {
        case currentUser:
            messageLeading.constant = 50
            messageContainerView.backgroundColor = appTheme.recievedMessageColor
        default:
            messageTrailing.constant = -50
            messageContainerView.backgroundColor = appTheme.sentMessageTheme
            statusLabel.text = message.meta.status
        }
        
        updateConstraintsIfNeeded()
    }
}

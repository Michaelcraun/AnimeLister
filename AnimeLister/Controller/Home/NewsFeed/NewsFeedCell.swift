//
//  NewsFeedCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

// TODO: - To do list
// TODO: Should pull post image from BE
// TODO: -

class NewsFeedCell: UITableViewCell, Themeable {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let userImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = theme.buttonColor
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = theme.subtitleFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = theme.detailFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    private let sourceLabel: UILabel = {
        let label = UILabel()
        label.font = theme.detailFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    private let postImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = theme.buttonColor
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
        label.numberOfLines = 0
        label.textColor = theme.textColor
        return label
    }()
    
    private let likeLabel: UILabel = {
        let label = UILabel()
        label.font = theme.subtitleFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    private let shareLabel: UILabel = {
        let label = UILabel()
        label.font = theme.subtitleFont
        label.textColor = theme.detailTextColor
        return label
    }()
    
    private var postImageHeight: NSLayoutConstraint!
    var post: Post?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        postImageHeight = NSLayoutConstraint(
            item: postImageView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 0)
        
        // Layout cell
        containerView.fillTo(
            self,
            withPadding: .init(top: 5, left: 0, bottom: 5, right: 0))
        
        userImageView.anchor(
            to: containerView,
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 0),
            size: .init(width: 40, height: 40))
        
        nameLabel.anchor(
            to: containerView,
            top: containerView.topAnchor,
            leading: userImageView.trailingAnchor,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        timeLabel.anchor(
            to: containerView,
            top: nameLabel.bottomAnchor,
            leading: userImageView.trailingAnchor,
            padding: .init(top: 2, left: 10, bottom: 0, right: 0))
        
        sourceLabel.anchor(
            to: containerView,
            top: nameLabel.bottomAnchor,
            leading: timeLabel.trailingAnchor,
            padding: .init(top: 2, left: 10, bottom: 0, right: 0))
        
        postImageView.anchor(
            to: containerView,
            top: timeLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        postImageView.addConstraint(postImageHeight)
        
        commentLabel.anchor(
            to: containerView,
            top: postImageView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        likeLabel.anchor(
            to: containerView,
            top: commentLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 10, left: 10, bottom: 10, right: 0))
        
        shareLabel.anchor(
            to: containerView,
            top: commentLabel.bottomAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 10, left: 0, bottom: 10, right: 10))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let post = post else { return }
        // Setup cell
        nameLabel.text = post.user.username
        timeLabel.text = post.createdAt.date?.printableDate
        sourceLabel.text = post.source ?? ""
        commentLabel.text = post.text
        likeLabel.text = "\(post.__meta__.likes) Likes".singularOrPluralRepresentaion
        shareLabel.text = "\(post.__meta__.shares) Shares".singularOrPluralRepresentaion
        
        // MARK: Test data. Should pull image from BE.
        if let image = UIImage(named: post.photo) {
            postImageView.image = image
            updateImageHeight()
        }
    }
    
    private func updateImageHeight() {
        postImageHeight.constant = 200
//        postImageView.updateConstraints()
    }
}

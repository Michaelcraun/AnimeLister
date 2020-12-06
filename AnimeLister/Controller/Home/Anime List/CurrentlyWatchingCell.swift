//
//  CurrentlyWatchingCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/14/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class CurrentlyWatchingCell: UITableViewCell, Themeable {
    private let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let quickUpdateView: UIView = {
        let view = UIView()
        view.backgroundColor = theme.buttonColor
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let thumbnailView: RoundedImageView = {
        let view = RoundedImageView()
        view.radius = 30
        return view
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.font = theme.titleFont
        return label
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = theme.buttonColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    var data: AnimeListCellData!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let anime = data.anime else { return }
        titleView.text = anime.anime.name
        progressLabel.text = "\(anime.progress.current) / \(anime.progress.total)"
        thumbnailView.setImage(UIImage(named: anime.anime.thumbnail))
    }
    
    private func layoutView() {
        quickUpdateView.anchor(
            to: container,
            leading: container.leadingAnchor,
            centerY: container.centerYAnchor,
            padding: .init(top: 0, left: 5, bottom: 0, right: 0),
            size: .init(width: 30, height: 30))
        
        thumbnailView.anchor(
            to: container,
            top: container.topAnchor,
            leading: quickUpdateView.trailingAnchor,
            bottom: container.bottomAnchor,
            padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        
        moreButton.anchor(
            to: container,
            trailing: container.trailingAnchor,
            centerY: container.centerYAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 5),
            size: .init(width: 30, height: 30))
        
        titleView.anchor(
            to: container,
            top: container.topAnchor,
            leading: thumbnailView.trailingAnchor,
            trailing: moreButton.leadingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        progressLabel.anchor(
            to: container,
            leading: thumbnailView.trailingAnchor,
            trailing: moreButton.leadingAnchor,
            bottom: container.bottomAnchor,
            padding: .init(top: 0, left: 5, bottom: 5, right: 5))
        
        container.fillTo(
            self,
            withPadding: .init(top: 5, left: 0, bottom: 5, right: 0))
    }
}

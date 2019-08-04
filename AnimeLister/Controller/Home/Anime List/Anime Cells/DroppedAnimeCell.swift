//
//  DroppedAnimeCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/21/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class DroppedAnimeCell: AnimeCell {
    private let droppedOnLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
        return label
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let anime = data.anime else { return }
        droppedOnLabel.text = "Dropped on: \(anime.meta.endDate)"
        ratingLabel.text = "\(anime.rating)"
    }
    
    private func layoutView() {
        thumbnailView.anchor(
            to: container,
            top: container.topAnchor,
            leading: container.leadingAnchor,
            bottom: container.bottomAnchor,
            padding: .init(top: 5, left: 5, bottom: 5, right: 0))
        
        moreButton.anchor(
            to: container,
            trailing: container.trailingAnchor,
            centerY: container.centerYAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 5),
            size: .init(width: 30, height: 30))
        
        ratingLabel.anchor(
            to: container,
            trailing: moreButton.leadingAnchor,
            centerY: container.centerYAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 5),
            size: .init(width: 40, height: 0))
        
        titleView.anchor(
            to: container,
            top: container.topAnchor,
            leading: thumbnailView.trailingAnchor,
            trailing: ratingLabel.leadingAnchor,
            padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        
        droppedOnLabel.anchor(
            to: container,
            leading: thumbnailView.trailingAnchor,
            trailing: ratingLabel.leadingAnchor,
            bottom: container.bottomAnchor,
            padding: .init(top: 0, left: 5, bottom: 5, right: 5))
        
        container.fillTo(
            self,
            withPadding: .init(top: 5, left: 0, bottom: 5, right: 0))
    }
}

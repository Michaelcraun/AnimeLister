//
//  OnHoldAnimeCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/21/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class OnHoldAnimeCell: AnimeCell {
    private let quickUpdateView: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "btn_add")?.withRenderingMode(.alwaysTemplate)
        button.addTarget(self, action: #selector(quickUpdateWasPressed), for: .touchUpInside)
        button.backgroundColor = theme.buttonColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 15
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
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
        progressLabel.text = "\(anime.progress.current) / \(anime.progress.total)"
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
    
    @objc private func quickUpdateWasPressed() {
        guard let anime = data.anime else { return }
        let endpoint = AnimeEndpoint.increaseCount(id: anime.id)
        NetworkRequest.router.request(endpoint) { (decodable) in
            
        }
    }
}

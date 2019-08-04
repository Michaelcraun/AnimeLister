//
//  AnimeCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/28/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

protocol AnimeCellDelegate: class {
    func animeCell(_ cell: AnimeCell, wasLongPressed: Bool)
    func moreWasTappedForAnimeCell(_ cell: AnimeCell)
}

class AnimeCell: UITableViewCell, Themeable {
    let container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let thumbnailView: RoundedImageView = {
        let view = RoundedImageView()
        view.radius = 30
        return view
    }()
    
    let titleView: UILabel = {
        let label = UILabel()
        label.font = theme.titleFont
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "btn_more")?.withRenderingMode(.alwaysTemplate)
        button.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
        button.backgroundColor = theme.buttonColor
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        button.layer.cornerRadius = 15
        button.setImage(image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private var longPress: UILongPressGestureRecognizer!
    var data: AnimeListCellData!
    var delegate: AnimeCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        longPress = UILongPressGestureRecognizer(target: self, action: #selector(cellWasLongPressed))
        self.addGestureRecognizer(longPress)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let anime = data.anime else { return }
        titleView.text = anime.anime.name
        thumbnailView.setImage(UIImage(named: anime.anime.thumbnail))
    }
    
    @objc private func moreButtonPressed() {
        delegate?.moreWasTappedForAnimeCell(self)
    }
    
    @objc private func cellWasLongPressed() {
        delegate?.animeCell(self, wasLongPressed: true)
    }
}

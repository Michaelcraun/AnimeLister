//
//  SectionHeaderCell.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/21/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class SectionHeaderCell: UITableViewCell, Themeable {
    private let label: UILabel = {
        let label = UILabel()
        label.font = theme.titleBarFont
        return label
    }()
    
    private let arrowView: UIImageView = {
        let view = UIImageView()
        view.tintColor = .black
        return view
    }()
    
    var data: AnimeListCellData!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        arrowView.anchor(
            to: self,
            trailing: self.trailingAnchor,
            centerY: self.centerYAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 10),
            size: .init(width: 20, height: 20))
        
        label.anchor(
            to: self,
            top: self.topAnchor,
            leading: self.leadingAnchor,
            trailing: arrowView.leadingAnchor,
            bottom: self.bottomAnchor,
            padding: .init(top: 5, left: 5, bottom: 5, right: 5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let closedImage = UIImage(named: "btn_expand")?.withVerticallyFlippedOrientation()?.withRenderingMode(.alwaysTemplate)
        let openImage = UIImage(named: "btn_expand")?.withRenderingMode(.alwaysTemplate)
        arrowView.image = data.isOpen ? openImage : closedImage
        label.text = data.type.value.capitalized
    }
}

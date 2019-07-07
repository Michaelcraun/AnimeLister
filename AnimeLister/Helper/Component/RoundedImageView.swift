//
//  RoundedImageView.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/28/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

/// A clickable, rounded UIImageView with shadows and a border. Defaults to a size of 100 by 100; can be adjusted by changing the radius property.
class RoundedImageView: UIView, Themeable {
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = theme.buttonColor
        view.layer.shadowColor = UIColor.black.cgColor
        return view
    }()
    
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.isUserInteractionEnabled = true
        view.layer.borderColor = theme.titleBarColor.cgColor
        view.layer.borderWidth = 5
        return view
    }()
    
    private var heightConstraint: NSLayoutConstraint!
    private var widthConstraint: NSLayoutConstraint!
    var image: UIImage?
    
    var radius: CGFloat {
        didSet {
            containerView.layer.cornerRadius = radius
            imageView.layer.cornerRadius = radius
        }
    }
    
    init(radius: CGFloat = 50.0) {
        self.radius = radius
        super.init(frame: .zero)
        
        containerView.fillTo(self)
        
        imageView.fillTo(containerView)
        
        heightConstraint = NSLayoutConstraint(
            item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: radius * 2)
        
        widthConstraint = NSLayoutConstraint(
            item: self,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: radius * 2)
        
        self.addConstraints([heightConstraint, widthConstraint])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        heightConstraint.constant = radius * 2
        widthConstraint.constant = radius * 2
        super.updateConstraints()
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
        self.image = image
    }
}

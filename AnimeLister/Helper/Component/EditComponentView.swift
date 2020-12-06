//
//  EditComponentView.swift
//  AnimeLister
//
//  Created by Michael Craun on 8/4/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

protocol EditComponentDelegate: class {
    func textFieldDidBeginEditing(_ textField: UITextField)
    func textFieldDidEndEditing(_ textField: UITextField)
}

enum ComponentType {
    case counter(title: String, currentValue: Int, maxValue: Int)
    case date(title: String, currentValue: String)
    case dropDown(title: String, currentValue: Any, data: [Any])
}

class EditComponentView: UIView, Themeable {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = theme.subtitleFont
        return label
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.font = theme.textFont
        return field
    }()
    
    private let supplementLabel: UILabel = {
        let label = UILabel()
        label.font = theme.textFont
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = theme.buttonColor
        button.layer.cornerRadius = 15
        return button
    }()
    
    private var type: ComponentType
    private var displaysSupplementLabel: Bool = false
    private var displaysActionButton: Bool = false
    private var dataPicker: DataPickerView?
    var delegate: EditComponentDelegate?
    
    init(ofType: ComponentType) {
        self.type = ofType
        super.init(frame: .zero)
        
        setup()
        layoutView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        textField.delegate = self
        
        switch type {
        case .counter(let title, let currentValue, let maxValue):
            titleLabel.text = title
            textField.text = "\(currentValue)"
            supplementLabel.text = "/ \(maxValue)"
            
            displaysActionButton = true
            displaysSupplementLabel = true
        case .date(let title, let currentValue):
            titleLabel.text = title
//            textField.text = Constants.displayDateFormatter.string(from: currentValue)
            textField.rightViewMode = .always
        case .dropDown(let title, let currentValue, let data):
            titleLabel.text = title
            textField.rightViewMode = .always
            
            dataPicker = DataPickerView()
        }
    }
    
    private func layoutView() {
        if displaysActionButton {
            titleLabel.anchor(
                to: self,
                top: self.topAnchor,
                leading: self.leadingAnchor,
                padding: .init(top: 5, left: 5, bottom: 0, right: 0))
            
            actionButton.anchor(
                to: self,
                leading: titleLabel.trailingAnchor,
                trailing: self.trailingAnchor,
                centerY: titleLabel.centerYAnchor,
                padding: .init(top: 0, left: 5, bottom: 0, right: 5),
                size: .init(width: 30, height: 30))
        } else {
            titleLabel.anchor(
                to: self,
                top: self.topAnchor,
                leading: self.leadingAnchor,
                trailing: self.trailingAnchor,
                padding: .init(top: 5, left: 5, bottom: 0, right: 5))
        }
        
        textField.anchor(
            to: self,
            top: titleLabel.bottomAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            padding: .init(top: 2, left: 5, bottom: 5, right: 0),
            size: .init(width: 80, height: 0))
        
        if displaysSupplementLabel {
            supplementLabel.anchor(
                to: self,
                top: titleLabel.bottomAnchor,
                leading: textField.trailingAnchor,
                trailing: self.trailingAnchor,
                bottom: self.bottomAnchor,
                padding: .init(top: 2, left: 0, bottom: 5, right: 5))
        } else {
            textField.anchor(trailing: self.trailingAnchor)
        }
    }
}

extension EditComponentView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(textField)
    }
}

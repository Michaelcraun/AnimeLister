//
//  ALTextField.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import MaterialComponents

class ALTextField: MDCTextField {
    var theme: Theme {
        return Settings.instance.theme
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = theme.textFont
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

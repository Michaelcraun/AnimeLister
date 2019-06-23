//
//  MaterialComponentsExt.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import MaterialComponents

extension MDCTextInputControllerOutlined {
    var isShowingError: Bool {
        return self.helperText != nil
    }
    
    func showError(_ errorText: String?) {
        var theme: Theme { return Settings.instance.theme }
        
        guard let text = errorText else {
            // Should reset controller to default values
            self.activeColor = theme.buttonColor
            self.floatingPlaceholderActiveColor = theme.buttonColor
            self.helperText = ""
            self.normalColor = MDCTextInputControllerOutlined.normalColorDefault
            return
        }
        
        self.activeColor = theme.errorColor
        self.floatingPlaceholderActiveColor = theme.errorColor
        self.helperText = text
        self.leadingUnderlineLabelTextColor = theme.errorColor
        self.normalColor = theme.errorColor
    }
}

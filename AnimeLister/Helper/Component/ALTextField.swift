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
        self.textColor = theme.textColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Checks the entered username for the following:
    /// - Username contains no special characters (@,#,$,%,&,*,(,),^,<,>,!,±)
    /// - Username contains only letters, underscores and numbers
    /// - Username is between 7 and 18 characters in length
    /// - returns: The field's text if it meets the prerequisite or nil
    func validateAsUsername() -> String? {
        let format = "[a-zA-Z0-9_.-]{7,18}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        return predicate.evaluate(with: text) ? text : nil
    }
    
    /// Checks the entered email for validation
    func validateAsEmail() -> String? {
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        return predicate.evaluate(with: text) ? text : nil
    }
    
    /// Checks the entered password for the following:
    /// - Password is at least 8 characters in length
    /// - Password has at least one capital letter
    /// - Password has at least one numeric or special character
    /// - returns: The field's text if it meets the prerequisite or nil
    func validateAsPassword() -> String? {
        let format = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: text) ? text : nil
    }
}

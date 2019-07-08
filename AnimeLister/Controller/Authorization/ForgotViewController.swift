//
//  ForgotViewController.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/28/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import MaterialComponents

class ForgotViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let insideView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let formStack: UIStackView = {
        let view = UIStackView()
        view.alignment = .fill
        view.axis = .vertical
        view.distribution = .fillProportionally
        return view
    }()
    
    private let emailField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.tag = 0
        return field
    }()
    
    private let codeField: ALTextField = {
        let field = ALTextField()
        field.keyboardType = .numbersAndPunctuation
        field.returnKeyType = .next
        field.tag = 1
        return field
    }()
    
    private let newPasswordField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.tag = 2
        return field
    }()
    
    private let confirmPasswordField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.tag = 3
        return field
    }()
    
    private let actionButton: MDCRaisedButton = {
        let button = MDCRaisedButton()
        button.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
        button.backgroundColor = theme.buttonColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.setTitle("SEND CODE", for: .normal)
        button.setTitleFont(theme.buttonFont, for: .normal)
        return button
    }()
    
    private var hasSentCode: Bool = false
    private var emailFieldController: MDCTextInputControllerOutlined!
    private var codeFieldController: MDCTextInputControllerOutlined!
    private var newPasswordFieldController: MDCTextInputControllerOutlined!
    private var confirmPasswordFieldController: MDCTextInputControllerOutlined!
    
    var authorizationCoordinator: AuthorizationCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addKeyboardAdjustablility()
        self.hidesKeyboardWhenTappedAround()
        
        setup()
        layoutView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Forgot Password"
        
        authorizationCoordinator?.navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        view.backgroundColor = appTheme.backgroundColor
        
        formStack.addArrangedSubview(emailField)
        formStack.addArrangedSubview(actionButton)
        
        emailFieldController = MDCTextInputControllerOutlined(textInput: emailField)
        emailFieldController.activeColor = appTheme.buttonColor
        emailFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        emailFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        emailFieldController.inlinePlaceholderFont = appTheme.detailFont
        emailFieldController.placeholderText = "Email"
        emailField.delegate = self
        
        codeFieldController = MDCTextInputControllerOutlined(textInput: codeField)
        codeFieldController.activeColor = appTheme.buttonColor
        codeFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        codeFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        codeFieldController.inlinePlaceholderFont = appTheme.detailFont
        codeFieldController.placeholderText = "Reset Code"
        codeField.delegate = self
        
        newPasswordFieldController = MDCTextInputControllerOutlined(textInput: newPasswordField)
        newPasswordFieldController.activeColor = appTheme.buttonColor
        newPasswordFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        newPasswordFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        newPasswordFieldController.inlinePlaceholderFont = appTheme.detailFont
        newPasswordFieldController.placeholderText = "Password"
        newPasswordField.delegate = self
        
        confirmPasswordFieldController = MDCTextInputControllerOutlined(textInput: confirmPasswordField)
        confirmPasswordFieldController.activeColor = appTheme.buttonColor
        confirmPasswordFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        confirmPasswordFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        confirmPasswordFieldController.inlinePlaceholderFont = appTheme.detailFont
        confirmPasswordFieldController.placeholderText = "Confirm Password"
        confirmPasswordField.delegate = self
    }
    
    private func layoutView() {
        scrollView.fillTo(view)
        
        insideView.fillTo(
            scrollView,
            andSize: .init(width: UIScreen.main.bounds.width, height: view.frame.height))
        
        formStack.anchor(
            to: insideView,
            top: insideView.topAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    @objc private func handleButtonTap() {
        guard let email = emailField.validateAsEmail() else {
            emailFieldController.showError("A valid email is required.")
            return
        }
        
        if hasSentCode {
            // Confirm rest of form and call reset endpoint
            guard let code = codeField.text, let _ = Int(code) else {
                codeFieldController.showError("Valid 6-digit code is required.")
                return
            }
            
            guard let newPassword = newPasswordField.validateAsPassword() else {
                newPasswordFieldController.showError("A valid password is required.")
                return
            }
            
            guard let confirmedPassword = confirmPasswordField.validateAsPassword() else {
                confirmPasswordFieldController.showError("Password confirmation is reuired.")
                return
            }
            
            if newPassword != confirmedPassword {
                newPasswordFieldController.showError("Passwords do not match.")
                confirmPasswordFieldController.showError("Passwords do not match.")
            } else {
                let endpoint = AuthorizationEndPoint.reset(email: email, code: code, newPassword: newPassword)
                NetworkRequest.router.request(endpoint) { (login) in
                    print("AUTH: Password has been reset! Should navigate to main with new credentails!")
                    self.authorizationCoordinator?.navigateToMain()
                }
            }
        } else {
            NetworkRequest.router.delegate = self
            let endpoint = AuthorizationEndPoint.forgot(email: email)
            NetworkRequest.router.request(endpoint) { (_) in
                self.showAlert(.verificationCode(email: email), withActions: [])
                self.hasSentCode = true
                self.updateForm()
            }
        }
    }
    
    private func updateForm() {
        emailField.isEnabled = false
        actionButton.setTitle("RESET PASSWORD", for: .normal)
        
        formStack.insertArrangedSubview(confirmPasswordField, at: 1)
        formStack.insertArrangedSubview(newPasswordField, at: 1)
        formStack.insertArrangedSubview(codeField, at: 1)
    }
}

extension ForgotViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 && !hasSentCode {
            textField.resignFirstResponder()
            handleButtonTap()
        } else {
            if let nextField = view.viewWithTag(textField.tag + 1) as? ALTextField {
                nextField.becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                handleButtonTap()
            }
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case emailField:
            emailFieldController.helperText = "user@example.com"
        case codeField:
            codeFieldController.helperText = "6-digit code sent to your email"
        case newPasswordField:
            newPasswordFieldController.helperText = "8+ characters, 1 capital, 1 number / special character"
        case confirmPasswordField:
            confirmPasswordFieldController.helperText = "8+ characters, 1 capital, 1 number or special character"
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case emailField: emailFieldController.showError(nil)
        case codeField: codeFieldController.showError(nil)
        case newPasswordField: newPasswordFieldController.showError(nil)
        case confirmPasswordField: confirmPasswordFieldController.showError(nil)
        default: break
        }
    }
}

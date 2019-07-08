//
//  LoginVC.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import MaterialComponents

class LoginViewController: UIViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return appTheme.statusBarStyle
    }
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    private let insideView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let logoView: RoundedImageView = {
        let view = RoundedImageView()
        view.setImage(UIImage(named: "dbz"))
        view.radius = 75
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = theme.titleFont
        label.text = "AnimeLister"
        label.textColor = theme.textColor
        return label
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
    
    let passwordField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.tag = 1
        return field
    }()
    
    let forgotPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = theme.detailFont
        label.isUserInteractionEnabled = true
        label.text = "FORGOT PASSWORD?"
        label.textColor = theme.textColor
        return label
    }()
    
    let loginButton: MDCRaisedButton = {
        let button = MDCRaisedButton()
        button.addTarget(self, action: #selector(signinTapped), for: .touchUpInside)
        button.backgroundColor = theme.buttonColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.setTitle("LOGIN", for: .normal)
        button.setTitleFont(theme.buttonFont, for: .normal)
        return button
    }()
    
    let signupLabel: UILabel = {
        let label = UILabel()
        label.font = theme.subtitleFont
        label.isUserInteractionEnabled = true
        label.text = "DON'T HAVE AN ACCOUNT?"
        label.textAlignment = .center
        label.textColor = theme.textColor
        return label
    }()
    
    var authCoordinator: AuthorizationCoordinator?
    var emailFieldController: MDCTextInputControllerOutlined!
    var passwordFieldController: MDCTextInputControllerOutlined!
    var forgotTap: UITapGestureRecognizer!
    var signupTap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = appTheme.backgroundColor
        self.addKeyboardAdjustablility()
        self.hidesKeyboardWhenTappedAround()
        
        layoutView()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        authCoordinator?.navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    private func setup() {
        forgotTap = UITapGestureRecognizer(target: self, action: #selector(forgotTapped))
        forgotPasswordLabel.addGestureRecognizer(forgotTap)
        
        signupTap = UITapGestureRecognizer(target: self, action: #selector(signupTapped))
        signupLabel.addGestureRecognizer(signupTap)
        
        emailFieldController = MDCTextInputControllerOutlined(textInput: emailField)
        emailFieldController.activeColor = appTheme.buttonColor
        emailFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        emailFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        emailFieldController.inlinePlaceholderFont = appTheme.detailFont
        emailFieldController.placeholderText = "Email"
        emailField.delegate = self
        
        passwordFieldController = MDCTextInputControllerOutlined(textInput: passwordField)
        passwordFieldController.activeColor = appTheme.buttonColor
        passwordFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        passwordFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        passwordFieldController.inlinePlaceholderFont = appTheme.detailFont
        passwordFieldController.placeholderText = "Password"
        passwordField.delegate = self
    }
    
    private func layoutView() {
        scrollView.fillTo(view)
        
        insideView.fillTo(
            scrollView,
            andSize: .init(width: UIScreen.main.bounds.width, height: 0))
        
        logoView.anchor(
            to: insideView,
            top: insideView.topAnchor,
            centerX: insideView.centerXAnchor,
            padding: .init(top: 100, left: 0, bottom: 0, right: 0))
        
        titleLabel.anchor(
            to: insideView,
            top: logoView.bottomAnchor,
            centerX: insideView.centerXAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        emailField.anchor(
            to: insideView,
            top: titleLabel.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        passwordField.anchor(
            to: insideView,
            top: emailField.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        forgotPasswordLabel.anchor(
            to: insideView,
            top: passwordField.bottomAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: -5, left: 0, bottom: 0, right: 10))
        
        loginButton.anchor(
            to: insideView,
            top: forgotPasswordLabel.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 10, left: 10, bottom: 0, right: 10))
        
        signupLabel.anchor(
            to: insideView,
            top: loginButton.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            bottom: insideView.bottomAnchor,
            padding: .init(top: 15, left: 10, bottom: 10, right: 10))
    }
    
//    override func keyboardWillShow(_ notification: NSNotification) {
//        guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
//            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
//        }, completion: nil)
//    }
//
//    override func keyboardWillHide(_ notification: NSNotification) {
//        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
//            self.scrollView.contentInset = .zero
//        }, completion: nil)
//    }
    
    @objc private func forgotTapped() {
        authCoordinator?.navigateToForgotPassword()
    }
    
    @objc private func signinTapped() {
        guard let email = emailField.text, email != "" else {
            emailFieldController?.showError("Email is required.")
            emailField.becomeFirstResponder()
            return
        }
        
        emailFieldController.showError(nil)
        
        guard let password = passwordField.text, password != "" else {
            passwordFieldController?.showError("Password is required.")
            passwordField.becomeFirstResponder()
            return
        }
        
        passwordFieldController.showError(nil)
        
        login(email: email, password: password)
    }
    
    @objc private func signupTapped() {
        authCoordinator?.navigateToSignup()
    }
    
    private func login(email: String, password: String) {
        let endpoint = AuthorizationEndPoint.signin(email: email, password: password)
        NetworkRequest.router.request(endpoint) { (data) in
            // MARK: Must validate login here
            self.authCoordinator?.navigateToMain()
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let field = textField as! ALTextField
        switch field {
        case emailField: emailFieldController?.showError(nil)
        case passwordField: passwordFieldController?.showError(nil)
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            signinTapped()
            return true
        }
        return false
    }
}

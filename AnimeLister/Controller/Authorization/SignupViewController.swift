//
//  SignupViewController.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/28/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import MaterialComponents

class SignupViewController: UIViewController {
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
    
    private let profileImageView: RoundedImageView = {
        let view = RoundedImageView()
//        view.image = 
        view.radius = 75
        return view
    }()
    
    private let firstNameField: ALTextField = {
        let field = ALTextField()
        field.autocorrectionType = .no
        field.returnKeyType = .next
        field.tag = 0
        return field
    }()
    
    private let lastNameField: ALTextField = {
        let field = ALTextField()
        field.autocorrectionType = .no
        field.returnKeyType = .next
        field.tag = 1
        return field
    }()
    
    private let usernameField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .next
        field.tag = 2
        return field
    }()
    
    private let emailField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.keyboardType = .emailAddress
        field.returnKeyType = .next
        field.tag = 3
        return field
    }()
    
    private let passwordField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.tag = 4
        return field
    }()
    
    private let confirmPasswordField: ALTextField = {
        let field = ALTextField()
        field.autocapitalizationType = .none
        field.isSecureTextEntry = true
        field.returnKeyType = .next
        field.tag = 5
        return field
    }()
    
    private let registerButton: MDCRaisedButton = {
        let button = MDCRaisedButton()
        button.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        button.backgroundColor = theme.buttonColor
        button.contentEdgeInsets = UIEdgeInsets(top: 12.5, left: 0, bottom: 12.5, right: 0)
        button.setTitle("REGISTER", for: .normal)
        button.setTitleFont(theme.buttonFont, for: .normal)
        return button
    }()
    
    private var imageTap: UITapGestureRecognizer!
    private let imageManager = ImageManager()
    private var firstNameFieldController: MDCTextInputControllerOutlined!
    private var lastNameFieldController: MDCTextInputControllerOutlined!
    private var usernameFieldController: MDCTextInputControllerOutlined!
    private var emailFieldController: MDCTextInputControllerOutlined!
    private var passwordFieldController: MDCTextInputControllerOutlined!
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
        self.title = "Signup"
        
        authorizationCoordinator?.navigationController.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup() {
        view.backgroundColor = appTheme.backgroundColor
        
        imageTap = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        profileImageView.addGestureRecognizer(imageTap)
        
        imageManager.delegate = self
        imageManager.parent = self
        
        firstNameFieldController = MDCTextInputControllerOutlined(textInput: firstNameField)
        firstNameFieldController.activeColor = appTheme.buttonColor
        firstNameFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        firstNameFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        firstNameFieldController.inlinePlaceholderFont = appTheme.detailFont
        firstNameFieldController.placeholderText = "First Name"
        firstNameField.delegate = self
        
        lastNameFieldController = MDCTextInputControllerOutlined(textInput: lastNameField)
        lastNameFieldController.activeColor = appTheme.buttonColor
        lastNameFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        lastNameFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        lastNameFieldController.inlinePlaceholderFont = appTheme.detailFont
        lastNameFieldController.placeholderText = "Last Name"
        lastNameField.delegate = self
        
        usernameFieldController = MDCTextInputControllerOutlined(textInput: usernameField)
        usernameFieldController.activeColor = appTheme.buttonColor
        usernameFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        usernameFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        usernameFieldController.inlinePlaceholderFont = appTheme.detailFont
        usernameFieldController.placeholderText = "Username"
        usernameField.delegate = self
        
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
        
        confirmPasswordFieldController = MDCTextInputControllerOutlined(textInput: confirmPasswordField)
        confirmPasswordFieldController.activeColor = appTheme.buttonColor
        confirmPasswordFieldController.floatingPlaceholderActiveColor = appTheme.buttonColor
        confirmPasswordFieldController.inlinePlaceholderColor = appTheme.placeHolderTextColor
        confirmPasswordFieldController.inlinePlaceholderFont = appTheme.detailFont
        confirmPasswordFieldController.placeholderText = "Confirm Password"
        confirmPasswordField.delegate = self
    }
    
    private func layoutView() {
        let screenWidth = UIScreen.main.bounds.width
        
        scrollView.fillTo(view)
        
        insideView.fillTo(
            scrollView,
            andSize: .init(width: screenWidth, height: 0))
        
        profileImageView.anchor(
            to: insideView,
            top: insideView.topAnchor,
            centerX: insideView.centerXAnchor,
            padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        
        firstNameField.anchor(
            to: insideView,
            top: profileImageView.bottomAnchor,
            leading: insideView.leadingAnchor,
            padding: .init(top: 20, left: 10, bottom: 0, right: 0),
            size: .init(width: (screenWidth - 30) / 2, height: 0))
        
        lastNameField.anchor(
            to: insideView,
            top: profileImageView.bottomAnchor,
            leading: firstNameField.trailingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 20, left: 10, bottom: 0, right: 10))
        
        usernameField.anchor(
            to: insideView,
            top: firstNameField.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        emailField.anchor(
            to: insideView,
            top: usernameField.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        passwordField.anchor(
            to: insideView,
            top: emailField.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        confirmPasswordField.anchor(
            to: insideView,
            top: passwordField.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            padding: .init(top: 0, left: 10, bottom: 0, right: 10))
        
        registerButton.anchor(
            to: insideView,
            top: confirmPasswordField.bottomAnchor,
            leading: insideView.leadingAnchor,
            trailing: insideView.trailingAnchor,
            bottom: insideView.bottomAnchor,
            padding: .init(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    override func keyboardWillShow(_ notification: NSNotification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: frame.height, right: 0)
        }, completion: nil)
    }
    
    override func keyboardWillHide(_ notification: NSNotification) {
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.scrollView.contentInset = .zero
        }, completion: nil)
    }
    
    @objc private func imageTapped() {
        imageManager.displayOptionSheet()
    }
    
    @objc private func registerTapped() {
        guard let firstName = firstNameField.text, firstName != "" else {
            firstNameFieldController.showError("First name is required.")
            return
        }
        
        guard let lastName = lastNameField.text, lastName != "" else {
            lastNameFieldController.showError("Last name is required.")
            return
        }
        
        guard let username = usernameField.validateAsUsername() else {
            usernameFieldController.showError("Valid username is required.")
            return
        }
        
        guard let email = emailField.validateAsEmail() else {
            emailFieldController.showError("Valid email is required.")
            return
        }
        
        guard let password = passwordField.validateAsPassword() else {
            passwordFieldController.showError("Valid password is required.")
            return
        }
        
        guard let confirmedPassword = confirmPasswordField.validateAsPassword() else {
            confirmPasswordFieldController.showError("Please confirm password.")
            return
        }
        
        guard (password == confirmedPassword) == true else {
            passwordFieldController.showError("Passwords do not match.")
            confirmPasswordFieldController.showError("Passwords do not match.")
            return
        }
        
        api_register(
            profileImage: profileImageView.image,
            firstName: firstName,
            lastName: lastName,
            username: username,
            email: email,
            password: password)
    }
    
    private func api_register(profileImage: UIImage?, firstName: String, lastName: String, username: String, email: String, password: String) {
        let endpoint = AuthorizationEndPoint.signup(
            photo: profileImage,
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            username: username)
        
        NetworkRequest.router.request(endpoint) { (data) in
            // MARK: Confirm results of request
            self.authorizationCoordinator?.navigateToLogin()
        }
    }
}

extension SignupViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = view.viewWithTag(textField.tag + 1) as? ALTextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            registerTapped()
        }
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case usernameField:
            usernameFieldController.helperText = "7 - 18 characters, no special characters"
        case emailField:
            emailFieldController.helperText = "user@example.com"
        case passwordField:
            passwordFieldController.helperText = "8+ characters, 1 capital, 1 number / special character"
        case confirmPasswordField:
            confirmPasswordFieldController.helperText = "8+ characters, 1 capital, 1 number or special character"
        default:
            break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case firstNameField: firstNameFieldController.showError(nil)
        case lastNameField: lastNameFieldController.showError(nil)
        case usernameField: usernameFieldController.showError(nil)
        case emailField: emailFieldController.showError(nil)
        case passwordField: passwordFieldController.showError(nil)
        case confirmPasswordField: confirmPasswordFieldController.showError(nil)
        default: break
        }
    }
}

extension SignupViewController: ImageManagerDelegate {
    func imageManager(didFinishWith image: UIImage) {
        profileImageView.setImage(image)
    }
    
    func imageManager(didRemoveImage: Bool) {
        profileImageView.setImage(nil)
    }
    
    func imageManager(didEncounterError error: String) {
        showAlert(.general(title: "Oh, no!", message: error), withActions: [defaultAlertAction])
    }
}

//
//  Alertable.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/29/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit
import AudioToolbox.AudioServices

struct AlertAction {
    var title: String?
    var style: UIAlertAction.Style
    var action: (UIAlertAction) -> Void
}

enum AlertResponse {
    case logout
    case settings
}

/// An enumeration of alerts to display to the user
enum Alert {
    case none
    case general(title: String?, message: String)
    case serverError(error: NetworkError)
    case verificationCode(email: String)
    
    case todo
    
    /// The title of a given alert. Defaults to nil.
    var title: String? {
        switch self {
        case .general(let title, _): return title
        case .serverError(let error): return "Status Code \(error.code)"
        case .verificationCode: return "Verificaiton Code"
            
        case .todo: return "Not implemented..."
        default: return nil
        }
    }
    
    /// The message of a given alert. Defaults to "An unexpected error occured. Please try again."
    var message: String? {
        switch self {
        case .general(_, let message): return message
        case .serverError(let error): return "\(error.description). Please contact support."
        case .verificationCode(let email): return "An email containing a confirmation code has been sent to \(email). Please input this code to reset your password."
            
        case .todo: return "Unfortunately, this hasn't been implemented, yet..."
        default: return "An unexpected error occured. Please contact support."
        }
    }
    
    /// The NotificationType of a given alert. Defaults to .error.
    var notificationType: NotificationType {
        switch self {
        default: return .error
        }
    }
}

/// An enumeration of vibration devices, such as a haptic engine
enum NotificationDevice {
    case haptic
    case vibrate
    case none
}

/// An enumeration of notification types
enum NotificationType {
    case error
    case success
    case warning
}

protocol Alertable {  }
extension UIViewController: Alertable {
    var defaultAlertAction: AlertAction {
        return AlertAction(title: "OK", style: .default, action: { (_) in
            self.dismissAlert()
        })
    }
}

extension Alertable where Self: UIViewController {
    func showActionSheet(_ alert: Alert, withActions actions: [AlertAction]) {
        let actionSheet = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .actionSheet)
        
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: action.style, handler: action.action)
            actionSheet.addAction(alertAction)
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            self.dismissAlert()
        }))
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    /// Presents a UIAlertController to the user over a blur effect
    /// - parameter alert: The type of Alert to display to the user
    func showAlert(_ alert: Alert, withActions actions: [AlertAction]) {
        DispatchQueue.main.async {
            self.view.addBackgroundEffect()
            
            let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
            
            if actions.count == 0 {
                let defaultAction = self.defaultAlertAction
                let alertAction = UIAlertAction(title: defaultAction.title, style: defaultAction.style, handler: defaultAction.action)
                alertController.addAction(alertAction)
            } else {
                for action in actions {
                    let alertAction = UIAlertAction(title: action.title, style: action.style, handler: action.action)
                    alertController.addAction(alertAction)
                }
            }
            
            self.present(alertController, animated: false, completion: nil)
        }
    }
    
    /// Fades the blur effect out and removes it from the superview
    func dismissAlert() {
        DispatchQueue.main.async {
            for subview in self.view.subviews {
                if subview.tag == 1001 {
                    subview.fadeAlphaOut()
                }
            }
        }
    }
}


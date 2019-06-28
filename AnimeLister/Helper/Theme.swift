//
//  Theme.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

// TODO: - To do list
// TODO: .dark.detailTextColor needs a new color
// TODO: -

protocol Themeable {
    var appTheme: Theme { get }
    static var theme: Theme { get }
}

extension Themeable {
    var appTheme: Theme {
        return Settings.instance.theme
    }
    
    static var theme: Theme {
        return Settings.instance.theme
    }
}

enum Theme {
    case dark
    case light
    
    init(_ themeName: String?) {
        switch themeName {
        case "dark": self = .dark
        case "light": self = .light
        default: self = .light
        }
    }
    
    // MARK: - Colors
    var backgroundColor: UIColor {
        switch self {
        case .dark: return UIColor(red: 12 / 255, green: 13 / 255, blue: 77 / 255, alpha: 1.0)
        case .light: return UIColor(red: 230 / 255, green: 227 / 255, blue: 248 / 255, alpha: 1.0)
        }
    }
    
    var buttonColor: UIColor {
        switch self {
        case .dark: return UIColor(red: 64 / 255, green: 43 / 255, blue: 204 / 255, alpha: 1.0)
        case .light: return UIColor(red: 28 / 255, green: 18 / 255, blue: 101 / 255, alpha: 1.0)
        }
    }
    
    var errorColor: UIColor {
        switch self {
        case .dark: return UIColor(red: 166 / 255, green: 0 / 255, blue: 0 / 255, alpha: 1.0)
        case .light: return UIColor(red: 255 / 255, green: 32 / 255, blue: 32 / 255, alpha: 1.0)
        }
    }
    
    var recievedMessageColor: UIColor {
        switch self {
        case .dark: return UIColor(red: 33 / 255, green: 17 / 255, blue: 150 / 255, alpha: 1.0)
        case .light: return UIColor(red: 138 / 255, green: 131 / 255, blue: 183 / 255, alpha: 1.0)
        }
    }
    
    var secondaryBackgroundColor: UIColor {
        switch self {
        case .dark: return UIColor(red: 8 / 255, green: 0 / 255, blue: 63 / 255, alpha: 1.0)
        case .light: return UIColor(red: 150 / 255, green: 140 / 255, blue: 219 / 255, alpha: 1.0)
        }
    }
    
    var sentMessageTheme: UIColor {
        switch self {
        case .dark: return UIColor(red: 12 / 255, green: 0 / 255, blue: 96 / 255, alpha: 1.0)
        case .light: return UIColor(red: 190 / 255, green: 186 / 255, blue: 217 / 255, alpha: 1.0)
        }
    }
    
    var titleBarColor: UIColor {
        switch self {
        case .dark: return UIColor(red: 8 / 255, green: 3 / 255, blue: 49 / 255, alpha: 1.0)
        case .light: return UIColor(red: 162 / 255, green: 149 / 255, blue: 249 / 255, alpha: 1.0)
        }
    }
    
    var titleBarTintColor: UIColor {
        return textColor
    }
    
    var statusBarStyle: UIStatusBarStyle {
        switch self {
        case .dark: return .lightContent
        case .light: return .default
        }
    }
    
    // MARK: - Fonts
    var buttonFont: UIFont? {
        return UIFont(name: "ChalkboardSE-Bold", size: 16.0)
    }
    
    var detailFont: UIFont? {
        return UIFont(name: "ChalkboardSE-Light", size: 14.0)
    }
    
    var subtitleFont: UIFont? {
        return UIFont(name: "ChalkboardSE-Regular", size: 18.0)
    }
    
    var textFont: UIFont? {
        return UIFont(name: "ChalkboardSE-Light", size: 16.0)
    }
    
    var titleFont: UIFont? {
        return UIFont(name: "ChalkboardSE-Bold", size: 20.0)
    }
    
    var titleBarFont: UIFont? {
        return UIFont(name: "ChalkboardSE-Bold", size: 22.0)
    }
    
    var placeHolderTextColor: UIColor? {
        switch self {
        case .dark: return .lightText
        case .light: return nil
        }
    }
    
    var detailTextColor: UIColor {
        switch self {
        case .dark: return textColor
        case .light: return .darkGray
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .dark: return .lightText
        case .light: return .darkText
        }
    }
}

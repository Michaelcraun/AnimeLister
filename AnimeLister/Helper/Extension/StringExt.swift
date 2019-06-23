//
//  StringExt.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

extension String {
    var date: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSSSSSZ"
        return formatter.date(from: self)
    }
    
    var singularOrPluralRepresentaion: String {
        var components = self.components(separatedBy: " ")
        guard let intValue = Int(components[0]) else { return self }
        switch intValue {
        case 0: return ""
        case 1: return "\(intValue) \(components[1].replacingOccurrences(of: "s", with: ""))"
        default: return self
        }
    }
    
//    func removingLastCharacter() -> String {
//        var newType: String = ""
//        let lastIndex = self.count
//
//        for index in 0..<self.count {
//            
//        }
//
//        return newType
//    }
}

//
//  DateExt.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

extension Date {
    var printableDate: String {
        let timePassed = self.timeIntervalSinceNow
        switch timePassed {
        case 0...60: return "A few seconds ago"
        case 61...3600: return "\(Int(timePassed / 60)) minutes ago"
        case 3600...518400: return "\(Int(timePassed / 3600)) hours ago"
        default: return Constants.displayDateFormatter.string(from: self)
        }
    }
}

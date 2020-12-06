//
//  Constants.swift
//  AnimeLister
//
//  Created by Michael Craun on 8/4/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum Constants {
    static var displayDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter
    }
    
    static var uploadDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, h:mm a"
        return formatter
    }
}

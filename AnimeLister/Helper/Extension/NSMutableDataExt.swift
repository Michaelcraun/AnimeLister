//
//  NSMutableDataExt.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: .utf8, allowLossyConversion: true)
        append(data!)
    }
}

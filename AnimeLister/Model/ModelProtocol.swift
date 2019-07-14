//
//  ModelProtocol.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

protocol Model {
    
}

protocol ModelList {
    var page: Int { get set }
    var perPage: Int { get set }
    var lastPage: Int { get set }
    var total: Int { get set }
}

class Progress: Decodable {
    var current: Int
    var total: Int
    
    var progress: Double {
        return Double(current) / Double(total)
    }
}

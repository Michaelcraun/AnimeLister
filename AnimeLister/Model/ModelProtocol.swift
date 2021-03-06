//
//  ModelProtocol.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

protocol Model {
    var id: Int { get set }
    var name: String { get set }
    var photo: String { get set }
    var thumbnail: String { get set }
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
    
    init(current: Int, total: Int) {
        self.current = current
        self.total = total
    }
}

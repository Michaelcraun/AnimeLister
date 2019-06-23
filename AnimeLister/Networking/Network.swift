//
//  Network.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum HTTPMethod {
    case delete
    case get
    case post
    case put
    
    var name: String {
        switch self {
        case .delete: return "DEL"
        case .get: return "GET"
        case .post: return "POST"
        case .put: return "PUT"
        }
    }
}

enum NetworkEnvironment {
    case development
    case production
    case testing
    
    var baseURL: String {
        switch self {
        case .development: return "https://db.animelister.com"
        case .production: return "https://db.animelister.com"
        case .testing: return "https://db.animelister.com"
        }
    }
    
    var bucketURL: String {
        switch self {
        case .development: return ""
        case .production: return ""
        case .testing: return ""
        }
    }
}

enum RefreshType {
    case bottom
    case pull
}

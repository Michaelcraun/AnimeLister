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

enum NetworkError: Error {
    case invalidToken
    case unknown
    
    var code: Int {
        switch self {
        case .invalidToken: return 401
        default: return -1
        }
    }
    
    var description: String {
        switch self {
        case .invalidToken: return "Found invalid token."
        case .unknown: return "An unknown error occured."
        }
    }
    
    init(_ code: Int) {
        switch code {
        case 401: self = .invalidToken
        default: self = .unknown
        }
    }
}

enum RefreshType {
    case bottom
    case pull
}

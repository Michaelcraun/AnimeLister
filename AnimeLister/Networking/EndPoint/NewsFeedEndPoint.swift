//
//  NewsFeedEndPoint.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum NewsFeedEndPoint: EndPoint {
    case news(page: Int)
    case post(id: Int)
    
    var body: [String : Any]? {
        switch self {
        case .news:
            return nil
        case .post(let id):
            return ["id" : id]
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .news(let page): return "/news?page=\(page)"
        case .post(let id): return "/post/\(id)"
        }
    }
}

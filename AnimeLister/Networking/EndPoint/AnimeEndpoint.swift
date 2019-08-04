//
//  AnimeEndpoint.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum AnimeEndpoint: EndPoint {
    case add(anime: Anime, section: String)
    case changeSection(id: Int, section: String)
    case increaseCount(id: Int)
    case remove(id: Int)
    
    var body: [String : Any?]? {
        switch self {
        case .add(let anime, let section):
            return ["animeID" : anime.id, "section" : section]
        case .changeSection(_, let section):
            return ["section" : section]
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .add: return .post
        case .changeSection: return .post
        case .increaseCount: return .put
        case .remove: return .delete
        }
    }
    
    var path: String {
        switch self {
        case .add: return "/anime/add"
        case .changeSection(let id, _): return "/anime/\(id)"
        case .increaseCount(let id): return "/anime/\(id)/increase"
        case .remove(let id): return "/anime/\(id)"
        }
    }
    
    func decode(data: Data, completion: @escaping (Decodable?) -> Void) {
        
    }
}

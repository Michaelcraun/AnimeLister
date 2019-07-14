//
//  AnimeModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class Anime: Decodable {
    let _rating: String
    let _type: String
    let id: Int
    let name: String
    let meta: AnimeMeta
    
    var rating: MediaRating.Anime? {
        return MediaRating.Anime(_rating)
    }
    
    var type: MediaType.Anime? {
        return MediaType.Anime(_type)
    }
}

class AnimeMeta: Decodable {
    let likes: Int
    let rating: Double
}

class AnimeList: Decodable, ModelList {
    var page: Int
    var perPage: Int
    var lastPage: Int
    var total: Int
    
    var anime: [Anime]
}

class UserAnime: Decodable {
    let _status: String
    let anime: Anime
    let meta: UserAnimeMeta
    let progress: Progress
    let rating: Double
    let tags: [String]
    
    var status: MediaStatus.Anime? {
        return MediaStatus.Anime(_status)
    }
}

class UserAnimeMeta: Decodable {
    var endDate: String
    var startDate: String
    var updatedDate: String
}

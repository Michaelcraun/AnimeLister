//
//  MangaModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class Manga: Decodable {
    let _rating: String
    let _type: String
    let id: Int
    let meta: MangaMeta
    let name: String
    
    var rating: MediaRating.Manga? {
        return MediaRating.Manga(_rating)
    }
    
    var type: MediaType.Manga? {
        return MediaType.Manga(_type)
    }
}

class MangaMeta: Decodable {
    let likes: Int
    let rating: Double
}

class MangaList: Decodable, ModelList {
    var page: Int
    var perPage: Int
    var lastPage: Int
    var total: Int
    
    var manga: [Manga]
}

class UserManga: Decodable {
    let _status: String
    let manga: Manga
    let meta: UserMangaMeta
    let rating: Double
    let progress: Progress
    
    var status: MediaStatus.Manga? {
        return MediaStatus.Manga(_status)
    }
}

class UserMangaMeta: Decodable {
    var endDate: String
    var startDate: String
    var updateDate: String
}

//
//  MangaModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class Manga: Decodable, Model {
    var _rating: String
    var _type: String
    var author: StaffMember?
    var id: Int
    var meta: MangaMeta
    var name: String
    var photo: String
    var publishDate: String
    var serializer: Serializer?
    var thumbnail: String
    var volumes: Int?
    
    var rating: MediaRating.Manga? {
        return MediaRating.Manga(_rating)
    }
    
    var type: MediaType.Manga? {
        return MediaType.Manga(_type)
    }
}

class Serializer: Decodable, Model {
    var id: Int
    var manga: [Manga]
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
}

class MangaMeta: Decodable {
    var likes: Int
    var rating: Double
}

class MangaList: Decodable, ModelList {
    var page: Int
    var perPage: Int
    var lastPage: Int
    var total: Int
    
    var manga: [Manga]
}

class UserManga: Decodable, Model {
    var _status: String
    var id: Int
    var manga: Manga
    var meta: UserMangaMeta
    var name: String
    var photo: String
    var rating: Double
    var progress: Progress
    var thumbnail: String
    
    var status: MediaStatus.Manga? {
        return MediaStatus.Manga(_status)
    }
}

class UserMangaMeta: Decodable {
    var endDate: String
    var startDate: String
    var updateDate: String
}

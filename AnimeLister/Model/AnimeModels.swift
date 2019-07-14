//
//  AnimeModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class Anime: Decodable, Model {
    var _rating: String
    var _type: String
    var characters: [Character]
    var id: Int
    var licensor: Licensor?
    var name: String
    var meta: AnimeMeta
    var photo: String
    var producer: Producer?
    var studio: Studio?
    var thumbnail: String
    
    var rating: MediaRating.Anime? {
        return MediaRating.Anime(_rating)
    }
    
    var type: MediaType.Anime? {
        return MediaType.Anime(_type)
    }
}

class Actor: Decodable, Model {
    var anime: [Anime]
    var characters: [Character]
    var id: Int
    var firstName: String
    var lastName: String
    var name: String
    var photo: String
    var thumbnail: String
}

class Licensor: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
}

class Producer: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
}

class Studio: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
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

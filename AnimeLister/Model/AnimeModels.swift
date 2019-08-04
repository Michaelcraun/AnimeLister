//
//  AnimeModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/13/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

struct Anime: Decodable, Model {
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
    var totalEpisodes: Int
    
    var rating: MediaRating.Anime? {
        return MediaRating.Anime(_rating)
    }
    
    var type: MediaType.Anime? {
        return MediaType.Anime(_type)
    }
}

struct Actor: Decodable, Model {
    var anime: [Anime]
    var characters: [Character]
    var id: Int
    var firstName: String
    var lastName: String
    var name: String
    var photo: String
    var thumbnail: String
}

struct Licensor: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
}

struct Producer: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
}

struct Studio: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var name: String
    var photo: String
    var staff: [StaffMember]
    var thumbnail: String
}

struct AnimeMeta: Decodable {
    let likes: Int
    let rating: Double
}

struct AnimeList: Decodable, ModelList {
    var page: Int
    var perPage: Int
    var lastPage: Int
    var total: Int
    
    var anime: [Anime]
}

struct UserAnime: Decodable {
    let _status: String
    let anime: Anime
    let id: Int
    let meta: UserAnimeMeta
    let progress: Progress
    let rating: Double
    let tags: [String]
    
    var status: MediaStatus.Anime? {
        return MediaStatus.Anime(_status)
    }
}

struct UserAnimeMeta: Decodable {
    var endDate: String
    var startDate: String
    var updatedDate: String
}

struct UserAnimeList {
    var statusType: MediaStatus.Anime
    var anime: [UserAnime]
    var isOpen: Bool
}

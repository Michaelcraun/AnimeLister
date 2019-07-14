//
//  UserModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class User: Decodable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let photo: String
    let anime: [UserAnime]
    let manga: [UserManga]
    let __meta__: UserMeta
    
    let friends: [User]
    
    init(id: Int, firstName: String, lastName: String, username: String, email: String, photo: String, anime: [UserAnime], manga: [UserManga], __meta__: UserMeta, friends: [User]) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.email = email
        self.photo = photo
        self.anime = anime
        self.manga = manga
        self.__meta__ = __meta__
        self.friends = friends
    }
}

extension User {
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

class UserMeta: Decodable {
    let likedPosts: [Int]
    
    init(likedPosts: [Int]) {
        self.likedPosts = likedPosts
    }
}

class UserList: Decodable, ModelList {
    var total: Int
    var perPage: Int
    var lastPage: Int
    var page: Int
    
    let users: [User]
}

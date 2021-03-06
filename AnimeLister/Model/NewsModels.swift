//
//  NewsModel.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class News: Decodable, ModelList {
    var total: Int
    var perPage: Int
    var lastPage: Int
    var page: Int
    
    let data: [Post]
}

class Post: Decodable {
    // Post information
    let id: Int
    let photo: String
    let text: String
    let source: String?
    let link: String?
    
    let meta: PostMeta
    
    // User information
    let user: User
    
    // Time stamps
    let createdAt: String
    
    init(id: Int, photo: String, text: String, source: String?, link: String?, __meta__: PostMeta, user: User, createdAt: String) {
        self.id = id
        self.photo = photo
        self.text = text
        self.source = source
        self.link = link
        self.meta = __meta__
        self.user = user
        self.createdAt = createdAt
    }
}

class PostMeta: Decodable {
    let likes: Int
    
    init(likes: Int, shares: Int) {
        self.likes = likes
    }
}

class Comment: Decodable {
    let id: Int
    let text: String
    let user: User
}

class CommentMeta: Decodable {
    let likes: Int
}

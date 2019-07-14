//
//  MessageModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class MessagesUserList: Decodable, ModelList {
    var total: Int
    var perPage: Int
    var lastPage: Int
    var page: Int
    
    let data: [User]
    
    init(total: Int, perPage: Int, page: Int, lastPage: Int, data: [User]) {
        self.total = total
        self.perPage = perPage
        self.page = page
        self.lastPage = lastPage
        self.data = data
    }
}

class Conversation: Decodable {
    let withUser: User
    var messages: [Message]
    
    init(withUser: User, messages: [Message]) {
        self.withUser = withUser
        self.messages = messages
    }
}

class Message: Decodable {
    let fromUser: User
    let toUser: User
    let text: String
    let meta: MessageMeta
    
    init(fromUser: User, toUser: User, text: String, meta: MessageMeta) {
        self.fromUser = fromUser
        self.toUser = toUser
        self.text = text
        self.meta = meta
    }
}

class MessageList: Decodable, ModelList {
    var page: Int
    var perPage: Int
    var lastPage: Int
    var total: Int
    
    let messages: [Message]
}

class MessageMeta: Decodable {
    let liked: Bool
    let status: String
    
    init(liked: Bool, status: String) {
        self.liked = liked
        self.status = status
    }
}

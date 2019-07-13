//
//  MessagesEndPoint.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/7/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum MessagesEndPoint: EndPoint {
    case messages(userID: Int, page: Int)
    case messagesList(page: Int)
    case send(userID: Int, message: String)
    
    var body: [String : Any?]? {
        switch self {
        case .send(let userID, let message):
            return ["userID" : userID, "message" : message]
        default:
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .messages: return .get
        case .messagesList: return .get
        case .send: return .post
        }
    }
    
    var path: String {
        switch self {
        case .messages(let userID, let page): return "/messages?id=\(userID)&page=\(page)"
        case .messagesList(let page): return "/messages/all?page=\(page)"
        case .send: return "/message"
        }
    }
    
    func decode(data: Data, completion: @escaping (Decodable?) -> Void) {
        if let messageList = try? JSONDecoder().decode(MessagesUserList.self, from: data) {
            completion(messageList)
        } else if let conversation = try? JSONDecoder().decode(Conversation.self, from: data) {
            completion(conversation)
        } else if let message = try? JSONDecoder().decode(Message.self, from: data) {
            completion(message)
        }
        
        completion(nil)
    }
}

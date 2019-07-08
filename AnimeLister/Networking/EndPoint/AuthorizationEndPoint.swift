//
//  AuthorizationEndPoint.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

enum AuthorizationEndPoint: EndPoint {
    case forgot(email: String)
    case reset(email: String, code: String, newPassword: String)
    case signin(email: String, password: String)
    case signup(photo: UIImage?, firstName: String, lastName: String, email: String, password: String, username: String)
    
    var body: [String : Any?]? {
        switch self {
        case .forgot(let email):
            return ["email" : email]
        case .reset(let email, let code, let newPassword):
            return ["email" : email, "code" : code, "newPassword" : newPassword]
        case .signin(let email, let password):
            return ["email" : email, "password" : password]
        case .signup(let photo, let firstName, let lastName, let email, let password, let username):
            return ["photo" : photo, "firstName" : firstName, "lastName" : lastName, "email" : email, "password" : password, "username" : username]
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        switch self {
        case .forgot: return "/auth/forgot"
        case .reset: return "/auth/reset"
        case .signin: return "/auth/signin"
        case .signup: return "/auth/signup"
        }
    }
    
    func decode(data: Data, completion: (Decodable?) -> Void) {
        if let user = try? JSONDecoder().decode(User.self, from: data) {
            completion(user)
        }
        
        completion(nil)
    }
}

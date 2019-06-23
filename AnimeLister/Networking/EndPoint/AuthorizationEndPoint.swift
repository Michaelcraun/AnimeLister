//
//  AuthorizationEndPoint.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum AuthorizationEndPoint: EndPoint {
    case forgotPassword(email: String)
    case resetPassword(email: String, code: String, newPassword: String)
    case signin(email: String, password: String)
    case signup(email: String, password: String, username: String)
    
    var body: [String : Any]? {
        switch self {
        case .forgotPassword(let email):
            return ["email" : email]
        case .resetPassword(let email, let code, let newPassword):
            return ["email" : email, "code" : code, "newPassword" : newPassword]
        case .signin(let email, let password):
            return ["email" : email, "password" : password]
        case .signup(let email, let password, let username):
            return ["email" : email, "password" : password, "username" : username]
        }
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var path: String {
        switch self {
        case .forgotPassword: return "/auth/forgot"
        case .resetPassword: return "/auth/reset"
        case .signin: return "/auth/signin"
        case .signup: return "/auth/signup"
        }
    }
}

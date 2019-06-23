//
//  NetworkManager.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

struct NetworkManager {
    static let environment: NetworkEnvironment = .development
    static let boundary: String = "Boundary-\(NSUUID().uuidString)"
    static var baseURL: String {
        return environment.baseURL
    }
}

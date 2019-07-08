//
//  EndPoint.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

protocol EndPoint {
    var body: [String : Any?]? { get }
    var bodyData: Data { get }
    var method: HTTPMethod { get }
    var path: String { get }
    func decode(data: Data, completion: @escaping (Decodable?) -> Void)
}

extension EndPoint {
    var bodyData: Data {
        let bodyData = NSMutableData()
        let boundaryPrefix: String = "--\(NetworkManager.boundary)\r\n"
        guard let body = body else { return bodyData as Data }
        
        for (key, value) in body {
            bodyData.appendString(boundaryPrefix)
            if let image = value as? UIImage {
                bodyData.appendString(boundaryPrefix)
                bodyData.appendString("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n")
                bodyData.appendString("Content-Type: image/jpg\r\n\r\n")
                bodyData.append(image.pngData()!)
                bodyData.appendString("\r\n")
            } else if let value = value {
                bodyData.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                bodyData.appendString("\(value)\r\n")
            }
        }
        
        bodyData.appendString("--".appending(NetworkManager.boundary.appending("--")))
        return bodyData as Data
    }
}

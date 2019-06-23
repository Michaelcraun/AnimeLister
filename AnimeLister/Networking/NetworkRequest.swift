//
//  NetworkRequest.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class NetworkRequest {
    static let router = NetworkRequest()
    
    private var currentTask: URLSessionTask?
    private var suspendedTasks: [URLSessionTask]?
    
    func request<T: EndPoint>(_ endpoint: T, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        suspendCurrentTaskIfNeeded()
        
        // Configure URL
        let apiURL = NetworkManager.baseURL + endpoint.path
        let url = URL(string: apiURL)
        let token = LocalStorage.store.get(for: .token)!
        
        // Configure request
        var request = URLRequest(url: url!)
        request.httpBody = endpoint.bodyData
        request.httpMethod = endpoint.method.name
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        
        // Configure session
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        currentTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                if let data = data {
                    print("NetworkRequest: Completed with data and no error!")
                    completion(data, response, error)
                } else {
                    print("NetworkRequest: Completed with no data or error...")
                    completion(nil, nil, nil)
                }
            } else {
                print("NetworkRequest: Completed with error...")
                completion(nil, nil, error)
            }
            self.resumeSuspendedTasksIfNeeded()
        })
        currentTask?.resume()
    }
    
    func download<T: EndPoint>(_ endpoint: T, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
    }
    
    private func suspendCurrentTaskIfNeeded() {
        guard let currentTask = currentTask else { return }
        currentTask.suspend()
        suspendedTasks?.append(currentTask)
    }
    
    private func resumeSuspendedTasksIfNeeded() {
        guard let suspendedTasks = suspendedTasks, suspendedTasks.count > 0 else { return }
        self.suspendedTasks?.first?.resume()
        self.suspendedTasks?.removeFirst(1)
    }
}

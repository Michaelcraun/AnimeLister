//
//  NetworkRequest.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/19/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

protocol NetworkRequestDelegate: class {
    func didEncounterError(_ code: Int?, error: Error?)
}

extension NetworkRequestDelegate where Self: UIViewController {
    func didEncounterError(_ code: Int?, error: Error?) {
        guard let code = code else {
            if let error = error {
                showAlert(.general(title: "Unknown Error", message: error.localizedDescription), withActions: [])
            }
            return
        }
        
        let networkError = NetworkError(code)
        if networkError == .invalidToken {
            // Should log user out and show login vc
        } else {
            showAlert(.serverError(error: networkError), withActions: [])
        }
    }
}

class NetworkRequest {
    static let router = NetworkRequest()
    
    private var currentTask: URLSessionTask?
    private var suspendedTasks: [URLSessionTask]?
    
    var delegate: NetworkRequestDelegate?
    
    func request<T: EndPoint>(_ endpoint: T, completion: @escaping (Decodable?) -> Void) {
        suspendCurrentTaskIfNeeded()
        
        // Configure URL
        let apiURL = NetworkManager.baseURL + endpoint.path
        let url = URL(string: apiURL)
        
        // Configure request
        var request = URLRequest(url: url!)
        request.httpBody = endpoint.bodyData
        request.httpMethod = endpoint.method.name
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = LocalStorage.store.get(for: .token) {
            request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        }
        
        // Configure session
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        currentTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                let error = "Could not get a response." as? Error
                completion(nil)
                self.delegate?.didEncounterError(nil, error: error)
                self.resumeSuspendedTasksIfNeeded()
                return
            }
            
            guard let error = error else {
                switch response.statusCode {
                case 200:
                    endpoint.decode(data: data!, completion: { (data) in
                        completion(data)
                        self.resumeSuspendedTasksIfNeeded()
                    })
                default:
                    completion(nil)
                    self.delegate?.didEncounterError(response.statusCode, error: NetworkError(response.statusCode))
                    self.resumeSuspendedTasksIfNeeded()
                }
                return
            }
            
            completion(nil)
            self.delegate?.didEncounterError(response.statusCode, error: error)
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

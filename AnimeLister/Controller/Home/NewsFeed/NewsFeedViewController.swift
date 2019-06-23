//
//  NewsFeedViewController.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

class NewsFeedViewController: UITableViewController {
    private let reuseID: String = "newsFeedCell"
    private var shouldFetchMore: Bool = false
    private var page: Int = 1
    private var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - TEST DATA!!
        posts = [post0, post1, post2]
        // MARK: -
        
        setup()
    }
    
    private func setup() {
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        refreshControl?.attributedTitle = NSAttributedString(string: "Loading...")
        refreshControl?.tintColor = appTheme.buttonColor
        
        tableView.backgroundColor = .clear
        tableView.register(NewsFeedCell.self, forCellReuseIdentifier: reuseID)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID) as! NewsFeedCell
        cell.post = posts[indexPath.row]
        cell.layoutSubviews()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row >= posts.count - 2 && shouldFetchMore {
            // Use this function to asynchronously load more posts
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Use this function to display more information about the tapped post
    }
    
    private func listNews(from refreshType: RefreshType) {
        let newsRequest = NewsFeedEndPoint.news(page: page)
        NetworkRequest.router.request(newsRequest) { (data, response, error) in
            self.refreshControl?.endRefreshing()
            
            guard let response = response as? HTTPURLResponse else {
                print("NEWS: Could not parse response as HTTPURLResponse...")
                return
            }
            
            switch response.statusCode {
            case 200:
                do {
                    let newsInfo = try JSONDecoder().decode(News.self, from: data!)
                    
                    switch refreshType {
                    case .bottom:
                        if self.page < newsInfo.lastPage {
                            self.page = newsInfo.lastPage
                            self.shouldFetchMore = false
                            self.listNews(from: .bottom)
                        } else if self.page == newsInfo.lastPage {
                            self.posts = newsInfo.data
                            self.page = self.page - 1 > 0 ? self.page - 1 : 0
                            self.shouldFetchMore = self.page > 1
                        } else {
                            self.posts += newsInfo.data
                            self.page = self.page - 1 > 0 ? self.page - 1 : 0
                            self.shouldFetchMore = self.page > 1
                        }
                    case .pull:
                        if self.page < newsInfo.lastPage {
                            self.page = newsInfo.lastPage
                            self.shouldFetchMore = false
                            self.listNews(from: .bottom)
                        } else if self.page == newsInfo.lastPage {
                            self.posts = newsInfo.data
                            self.page = self.page - 1 > 0 ? self.page - 1 : 0
                            self.shouldFetchMore = self.page > 1
                        }
                    }
                } catch let error {
                    print("NEWS: There was an error parsing news data:", error)
                }
            default:
                print("NEWS: Error obtaining news:", error ?? "nil", "with status code:", response.statusCode)
                break
            }
        }
    }
    
    @objc private func refreshData() {
        listNews(from: .pull)
    }
}

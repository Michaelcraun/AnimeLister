//
//  AnimeListViewController.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import UIKit

struct AnimeListCellData {
    var anime: UserAnime?
    var isOpen: Bool = false
    var type: MediaStatus.Anime = .currentlyWatching
}

class AnimeListViewController: UITableViewController {
    private var animeList: [UserAnimeList] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.title = "Anime List"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layoutView()
    }
    
    private func setup() {
        view.backgroundColor = appTheme.backgroundColor
        
        tableView.backgroundColor = .clear
        tableView.register(SectionHeaderCell.self, forCellReuseIdentifier: "headerCell")
        tableView.register(CompletedAnimeCell.self, forCellReuseIdentifier: "completedCell")
        tableView.register(CurrentlyWatchingCell.self, forCellReuseIdentifier: "currentCell")
        tableView.register(DroppedAnimeCell.self, forCellReuseIdentifier: "droppedCell")
        tableView.register(OnHoldAnimeCell.self, forCellReuseIdentifier: "onHoldCell")
        tableView.register(PlanToWatchAnimeCell.self, forCellReuseIdentifier: "planToWatchCell")
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        // MARK: TEST DATA!!
        let chobits = Anime(
            _rating: "tv-pg",
            _type: "tv",
            characters: [],
            id: 1,
            licensor: nil,
            name: "Chobits",
            meta: AnimeMeta(
                likes: 67465,
                rating: 7.51),
            photo: "",
            producer: nil,
            studio: nil,
            thumbnail: "chobits",
            totalEpisodes: 26)
        
        let dbz = Anime(
            _rating: "tv-y7",
            _type: "tv",
            characters: [],
            id: 0,
            licensor: nil,
            name: "Dragon Ball Z",
            meta: AnimeMeta(
                likes: 896754,
                rating: 8.29),
            photo: "",
            producer: nil,
            studio: nil,
            thumbnail: "dbz",
            totalEpisodes: 291)
        
        let anime = [
            UserAnime(
                _status: "currently watching",
                anime: dbz,
                id: 0,
                meta: UserAnimeMeta(
                    endDate: "",
                    startDate: "",
                    updatedDate: ""),
                progress: Progress(
                    current: 153,
                    total: 291),
                rating: 10.0,
                tags: []),
            UserAnime(
                _status: "currently watching",
                anime: chobits,
                id: 0,
                meta: UserAnimeMeta(
                    endDate: "",
                    startDate: "",
                    updatedDate: ""),
                progress: Progress(
                    current: 4,
                    total: 26),
                rating: 10.0,
                tags: []),
            UserAnime(
                _status: "completed",
                anime: dbz,
                id: 0,
                meta: UserAnimeMeta(
                    endDate: "",
                    startDate: "",
                    updatedDate: ""),
                progress: Progress(
                    current: 291,
                    total: 291),
                rating: 10.0,
                tags: []),
            UserAnime(
                _status: "dropped",
                anime: dbz,
                id: 0,
                meta: UserAnimeMeta(
                    endDate: "",
                    startDate: "",
                    updatedDate: ""),
                progress: Progress(
                    current: 5,
                    total: 291),
                rating: 2.0,
                tags: []),
            UserAnime(
                _status: "on hold",
                anime: dbz,
                id: 0,
                meta: UserAnimeMeta(
                    endDate: "",
                    startDate: "",
                    updatedDate: ""),
                progress: Progress(
                    current: 15,
                    total: 291),
                rating: 0.0,
                tags: []),
            UserAnime(
                _status: "plan to watch",
                anime: dbz,
                id: 0,
                meta: UserAnimeMeta(
                    endDate: "",
                    startDate: "",
                    updatedDate: ""),
                progress: Progress(
                    current: 0,
                    total: 291),
                rating: 0.0,
                tags: [])
        ]
        
        animeList = [
            UserAnimeList(statusType: .completed, anime: anime.filter({ $0.status == .completed }), isOpen: false),
            UserAnimeList(statusType: .currentlyWatching, anime: anime.filter({ $0.status == .currentlyWatching }), isOpen: false),
            UserAnimeList(statusType: .dropped, anime: anime.filter({ $0.status == .dropped }), isOpen: false),
            UserAnimeList(statusType: .onHold, anime: anime.filter({ $0.status == .onHold }), isOpen: false),
            UserAnimeList(statusType: .planToWatch, anime: anime.filter({ $0.status == .planToWatch }), isOpen: false)
        ]
    }
    
    private func layoutView() {
        
    }
}

extension AnimeListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return animeList.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch animeList[section].isOpen {
        case false:
            return 1
        case true:
            return animeList[section].anime.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = AnimeListCellData(
            anime: indexPath.row == 0 ? nil : animeList[indexPath.section].anime[indexPath.row - 1],
            isOpen: animeList[indexPath.section].isOpen,
            type: animeList[indexPath.section].statusType)
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! SectionHeaderCell
            cell.data = data
            cell.layoutSubviews()
            return cell
        } else {
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "completedCell") as! CompletedAnimeCell
                cell.data = data
                cell.delegate = self
                cell.layoutSubviews()
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "currentCell") as! CurrentlyWatchingCell
                cell.data = data
                cell.delegate = self
                cell.layoutSubviews()
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "droppedCell") as! DroppedAnimeCell
                cell.data = data
                cell.delegate = self
                cell.layoutSubviews()
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "onHoldCell") as! OnHoldAnimeCell
                cell.data = data
                cell.delegate = self
                cell.layoutSubviews()
                return cell
            case 4:
                let cell = tableView.dequeueReusableCell(withIdentifier: "planToWatchCell") as! PlanToWatchAnimeCell
                cell.data = data
                cell.delegate = self
                cell.layoutSubviews()
                return cell
            default:
                return UITableViewCell()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            animeList[indexPath.section].isOpen = !animeList[indexPath.section].isOpen
        } else {
            print("User selected an anime to view!")
        }
        
        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }
}

extension AnimeListViewController: AnimeCellDelegate {
    func animeCell(_ cell: AnimeCell, wasLongPressed: Bool) {
        
    }
    
    func moreWasTappedForAnimeCell(_ cell: AnimeCell) {
        
    }
}

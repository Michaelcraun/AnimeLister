//
//  Media.swift
//  AnimeLister
//
//  Created by Michael Craun on 7/14/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class Character: Decodable, Model {
    var actor: Actor?
    var anime: [Anime]
    var id: Int
    var manga: [Manga]
    var name: String
    var photo: String
    var thumbnail: String
}

enum MediaRating {
    enum Anime {
        case movie(rating: Movie?)
        case tv(rating: TV?)
        
        init?(_ rating: String) {
            // tv-y14
            // movie-nc17
            let parts = rating.components(separatedBy: "-")
            switch parts[0] {
            case "movie": self = .movie(rating: Movie(parts[1]))
            case "tv": self = .tv(rating: TV(parts [1]))
            default: return nil
            }
        }
        
        var value: String {
            switch self {
            case .movie(let rating): return "movie-\(rating!.value)"
            case .tv(let rating): return "tv-\(rating!.value)"
            }
        }
        
        enum Movie {
            case g
            case nc17
            case pg
            case pg13
            case r
            
            init?(_ rating: String) {
                switch rating {
                case "g": self = .g
                case "nc17": self = .nc17
                case "pg": self = .pg
                case "pg13": self = .pg13
                case "r": self = .r
                default: return nil
                }
            }
            
            var value: String {
                switch self {
                case .g: return "g"
                case .nc17: return "nc17"
                case .pg: return "pg"
                case .pg13: return "pg13"
                case .r: return "r"
                }
            }
            
            var description: String {
                switch self {
                case .g: return "This content is suitable for all ages."
                case .nc17: return "This content is specifically designed to be viewed by adults and therefore may be unsuitable for children under 17."
                case .pg: return "This content contains material that parents may find unsiutable for children under 16."
                case .pg13: return "This content contains material that parents may find unsuitable for children under 13."
                case .r: return "This content contains material that parents may find unsuitable for children under 17."
                }
            }
        }
        
        enum TV {
            case g
            case ma
            case pg
            case y
            case y14
            case y7
            
            init?(_ rating: String) {
                switch rating {
                case "g": self = .g
                case "ma": self = .ma
                case "pg": self = .pg
                case "y": self = .y
                case "y14": self = .y14
                case "y7": self = .y7
                default: return nil
                }
            }
            
            var value: String {
                switch self {
                case .g: return "g"
                case .ma: return "ma"
                case .pg: return "pg"
                case .y: return "y"
                case .y14: return "y14"
                case .y7: return "y7"
                }
            }
            
            var description: String {
                switch self {
                case .g: return "This content is suitable for all ages."
                case .ma: return "This content is specifically designed to be viewed by adults and therefore may be unsuitable for children under 17."
                case .pg: return "This content contains material that parents may find unsuitable for children under 16."
                case .y: return "This content is designed to be appropriate for all children."
                case .y14: return "This content contains material that parents may find unsuitable for children under 14."
                case .y7: return "This content contains material that parents may find unsuitable for children under 7."
                }
            }
        }
    }
    
    enum Manga {
        case e
        case m
        case ot
        case t
        case y
        
        init?(_ rating: String) {
            switch rating {
            case "e": self = .e
            case "m": self = .m
            case "ot": self = .ot
            case "y": self = .y
            default: return nil
            }
        }
        
        var value: String {
            switch self {
            case .e: return "e"
            case .m: return "m"
            case .ot: return "ot"
            case .t: return "t"
            case .y: return "y"
            }
        }
        
        var description: String {
            switch self {
            case .e: return "This content is suitable for all ages."
            case .m: return "This content is specifically designed to be viewed by adults and therefore may be unsuitable for children under 17."
            case .ot: return "This content contains material that parents may find unsuitable for children under 16."
            case .t: return "This content contains material that parents may find unsuitable for children under 14."
            case .y: return "This content contains material that parents may find unsuitable for children under 10."
            }
        }
    }
}

enum MediaStatus {
    enum Anime {
        case completed
        case currentlyWatching
        case dropped
        case onHold
        case planToWatch
        
        static let list: [MediaStatus.Anime] = [
            .completed,
            .currentlyWatching,
            .dropped,
            .onHold,
            .planToWatch]
        
        init?(_ status: String) {
            switch status {
            case "completed": self = .completed
            case "currently watching": self = .currentlyWatching
            case "dropped": self = .dropped
            case "on hold": self = .onHold
            case "plan to watch": self = .planToWatch
            default: return nil
            }
        }
        
        var value: String {
            switch self {
            case .completed: return "completed"
            case .currentlyWatching: return "currently watching"
            case .dropped: return "dropped"
            case .onHold: return "on hold"
            case .planToWatch: return "plan to watch"
            }
        }
    }
    
    enum Manga {
        case completed
        case currentlyReading
        case dropped
        case onHold
        case planToRead
        
        init?(_ status: String) {
            switch status {
            case "completed": self = .completed
            case "currently reading": self = .currentlyReading
            case "dropped": self = .dropped
            case "on hold": self = .onHold
            case "plan to read": self = .planToRead
            default: return nil
            }
        }
        
        var value: String {
            switch self {
            case .completed: return "completed"
            case .currentlyReading: return "currently reading"
            case .dropped: return "dropped"
            case .onHold: return "on hold"
            case .planToRead: return "plan to read"
            }
        }
    }
}

enum MediaType {
    enum Anime {
        case hentai
        case movie
        case ona
        case ova
        case tv
        
        init?(_ type: String) {
            switch type {
            case "hentai": self = .hentai
            case "movie": self = .movie
            case "ona": self = .ona
            case "ova": self = .ova
            case "tv": self = .tv
            default: return nil
            }
        }
        
        var value: String {
            switch self {
            case .hentai: return "hentai"
            case .movie: return "movie"
            case .ona: return "ona"
            case .ova: return "ova"
            case .tv: return "tv"
            }
        }
    }
    
    enum Manga {
        case doujinshi
        case manga
        
        init?(_ type: String) {
            switch type {
            case "doujinshi": self = .doujinshi
            case "manga": self = .manga
            default: return nil
            }
        }
        
        var value: String {
            switch self {
            case .doujinshi: return "doujinshi"
            case .manga: return "manga"
            }
        }
    }
}

class StaffMember: Decodable, Model {
    var anime: [Anime]
    var id: Int
    var licensors: [Licensor]
    var manga: [Manga]
    var name: String
    var photo: String
    var producers: [Producer]
    var serializers: [Serializer]
    var studios: [Studio]
    var thumbnail: String
}

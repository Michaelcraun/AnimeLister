//
//  MediaModels.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

class Media: Decodable {
    let id: Int
    let name: String
    
    let __meta__: MediaMeta
}

class MediaMeta: Decodable {
    let likes: Int
    let rating: Double
}

class Anime: Media {
    
}

class Manga: Media {
    
}

//
//  LocalStorage.swift
//  AnimeLister
//
//  Created by Michael Craun on 6/18/19.
//  Copyright © 2019 Craunic Productions. All rights reserved.
//

import Foundation

enum StorageKey: String {
    case theme
    case token
}

enum Folder {
    case temp
    
    var name: String {
        switch self {
        case .temp: return "anime_lister_temp"
        }
    }
    
    static func list() -> [Folder] {
        return []
    }
}

class LocalStorage {
    static let store = LocalStorage()
    
    private let defaults = UserDefaults.standard
    
    func set(_ value: String, for key: StorageKey) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func get(for key: StorageKey) -> String? {
        guard let value = defaults.string(forKey: key.rawValue) else { return nil }
        return value
    }
    
    func remove(for key: StorageKey) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func clearDeviceStorage(inFolder folder: Folder) {
        guard let folderURL = URL.createFolder(named: folder.name) else { return }
        do {
            let contents = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: [])
            for item in contents {
                do {
                    try FileManager.default.removeItem(at: item)
                } catch let error {
                    print("STORAGE: Error removing item at \(item):", error)
                }
            }
        } catch let error {
            print("STORAGE: Error finding contents of \(folderURL):", error)
        }
    }
}

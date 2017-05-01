//
//  Song.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/28/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

struct Song {
    fileprivate (set) var id: Int
    fileprivate (set) var name: String
    fileprivate (set) var censoredName: String
    fileprivate (set) var trackTime: Int
    fileprivate (set) var isExplicit: Bool
}


extension Song {
    init?(json: [String: Any]) {
        
        struct Key {
            static let id = "trackId"
            static let name = "trackName"
            static let censoredName = "trackCensoredName"
            static let trackTime = "trackTimeMillis"
            static let isExplicit = "trackExplicitness"
        }
        
        guard let idValue = json[Key.id] as? Int,
            let nameValue = json[Key.name] as? String,
            let censoredNameValue = json[Key.censoredName] as? String,
            let trackTimeValue = json[Key.trackTime] as? Int,
            let isExplicitString = json[Key.isExplicit] as? String else {
                return nil
        }
        
        self.id = idValue
        self.name = nameValue
        self.censoredName = censoredNameValue
        self.trackTime = trackTimeValue
        self.isExplicit = isExplicitString == "notExplicit" ? false : true
    }
}

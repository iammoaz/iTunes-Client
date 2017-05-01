//
//  Artist.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/28/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation


class Artist {
    private (set) var id: Int
    private (set) var name: String
    private (set) var genre: Genre
    private (set) var albums: [Album]
    
    init(id: Int, name: String, genre: Genre, albums: [Album]) {
        self.id = id
        self.name = name
        self.genre = genre
        self.albums = albums
    }
    
    func update(with albums: [Album]) {
        self.albums = albums
    }
}

extension Artist {
    convenience init?(json: [String: Any]) {
        struct Key {
            static let artistName = "artistName"
            static let artistId = "artistId"
            static let primaryGenreId = "primaryGenreId"
        }
        
        guard let artistName = json[Key.artistName] as? String, let artistId = json[Key.artistId] as? Int, let primaryGenreId = json[Key.primaryGenreId] as? Int, let primaryGenreValue = Genre(rawValue: primaryGenreId) else {
            return nil
        }
        
        self.init(id: artistId, name: artistName, genre: primaryGenreValue, albums: [])
    }
}

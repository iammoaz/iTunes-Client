//
//  Album.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/28/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

enum AlbumArtworkState {
    case placeholder
    case downloaded
    case failed
}

class Album {
    private (set) var id: Int
    private (set) var name: String
    private (set) var artistName: String
    private (set) var censoredName: String
    private (set) var artworkUrl: String
    private (set) var isExplicit: Bool
    private (set) var numberOfTracks: Int
    private (set) var releaseDate: Date
    private (set) var genre: Genre
    private (set) var songs = [Song]()
    private (set) var artwork: UIImage?
    private (set) var artworkState = AlbumArtworkState.placeholder
    
    init(id: Int, name: String, artistName: String, censoredName: String, artworkUrl: String, isExplicit: Bool, numberOfTracks: Int, releaseDate: Date, genre: Genre) {
        self.id = id
        self.name = name
        self.artistName = artistName
        self.censoredName = censoredName
        self.artworkUrl = artworkUrl
        self.isExplicit = isExplicit
        self.numberOfTracks = numberOfTracks
        self.releaseDate = releaseDate
        self.genre = genre
    }
    
    func update(with songs: [Song]) {
        self.songs.append(contentsOf: songs)
    }
    
    func update(with image: UIImage?) {
        self.artwork = image
    }
    
    func update(with state: AlbumArtworkState) {
        self.artworkState = state
    }
}

extension Album {
    convenience init?(json: [String: Any]) {
        struct Key {
            static let id = "collectionId"
            static let artistName = "artistName"
            static let name = "collectionName"
            static let censoredName = "collectionCensoredName"
            static let artworkUrl = "artworkUrl100"
            static let collectionExplicitness = "collectionExplicitness"
            static let trackCount = "trackCount"
            static let releaseDate = "releaseDate"
            static let primaryGenre = "primaryGenreName"
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        guard let idValue = json[Key.id] as? Int,
            let artistNameValue = json[Key.artistName] as? String,
            let nameValue = json[Key.name] as? String,
            let censoredNameValue = json[Key.censoredName] as? String,
            let artworkUrlString = json[Key.artworkUrl] as? String,
            let isExplicitValue = json[Key.collectionExplicitness] as? String,
            let numberOfTracksValue = json[Key.trackCount] as? Int,
            let releaseDateString = json[Key.releaseDate] as? String,
            let releaseDateValue = formatter.date(from: releaseDateString),
            let primaryGenreString = json[Key.primaryGenre] as? String,
            let primaryGenreValue = Genre(name: primaryGenreString) else { return nil }
        
        let isExplicit = isExplicitValue == "notExplicit" ? false : true
        
        self.init(id: idValue, name: nameValue, artistName: artistNameValue, censoredName: censoredNameValue, artworkUrl: artworkUrlString, isExplicit: isExplicit, numberOfTracks: numberOfTracksValue, releaseDate: releaseDateValue, genre: primaryGenreValue)
    }
}

//
//  ItunesAPIClient.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/30/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

class ItunesAPIClient {
    
    typealias Results = [[String: Any]]
    
    let downloader = JSONDownloader()
    
    func searchForArtists(withTerm term: String, completion: @escaping ([Artist], ItunesError?) -> Void) {
        let endpoint = Itunes.search(term: term, media: .music(entity: .musicArtist, attribute: .artistTerm))
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let artists = results.flatMap { Artist(json: $0) }
            completion(artists, nil)
        }
    }
    
    func lookupArtist(withId id: Int, completion: @escaping(Artist?, ItunesError?) -> Void) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            
            guard let artistInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain artist info"))
                return
            }
            
            guard let artist = Artist(json: artistInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse artist info"))
                return
            }
            
            let albumResults = results[1..<results.count]
            let album = albumResults.flatMap { Album(json: $0) }
            
            artist.update(with: album)
            completion(artist, nil)
        }
    }
    
    func lookupAlbum(withId id: Int, completion: @escaping(Album?, ItunesError?) -> Void) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.song)
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            
            guard let albumInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain artist info"))
                return
            }
            
            guard let album = Album(json: albumInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse artist info"))
                return
            }
            
            let songResults = results[1..<results.count]
            let songs = songResults.flatMap { Song(json: $0) }
            
            album.update(with: songs)
            completion(album, nil)
        }
    }
    
    private func performRequest(with endpoint: Endpoint, completion: @escaping (Results?, ItunesError?) -> Void) {
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let results = json["results"] as? [[String: Any]] else {
                    completion(nil, .jsonParsingFailure(message: "JSON data does not contain results"))
                    return
                }
                
                completion(results, nil)
            }
        }
        task.resume()
    }
}
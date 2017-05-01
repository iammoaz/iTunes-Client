//
//  AlbumCellViewModel.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

struct AlbumCellViewModel {
    fileprivate (set) var title: String
    fileprivate (set) var releaseDate: String
    fileprivate (set) var genre: String
    fileprivate (set) var artwork: UIImage?
}

extension AlbumCellViewModel {
    init(album: Album) {
        self.title = album.censoredName
        self.genre = album.genre.name
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        
        formatter.dateFormat = "MMM dd, yyyy"
        self.releaseDate = formatter.string(from: album.releaseDate)
        
        if album.artworkState == .downloaded {
            self.artwork = album.artwork!
        }
    }
}

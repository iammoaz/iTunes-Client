//
//  ArtworkDownloader.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/30/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit


class ArtworkDownloader: Operation {
    private (set) var album: Album
    
    init(album: Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        guard let url = URL(string: album.artworkUrl) else { return }
        
        let imageData = try! Data(contentsOf: url)
        
        if self.isCancelled {
            return
        }
        
        if imageData.count > 0 {
            album.update(with: UIImage(data: imageData))
            album.update(with: .downloaded)
        } else {
            album.update(with: .failed)
        }
    }
}

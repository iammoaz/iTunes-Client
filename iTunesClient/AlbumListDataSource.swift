//
//  AlbumListDataSource.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class AlbumListDataSource: NSObject {
    fileprivate var albums: [Album]
    fileprivate let pendingOperations = PendingOperations()
    fileprivate let tableView: UITableView
    
    init(albums: [Album], tableView: UITableView) {
        self.albums = albums
        self.tableView = tableView
        super.init()
    }
    
    func album(at indexPath: IndexPath) -> Album {
        return albums[indexPath.row]
    }
    
    func update(with albums: [Album]) {
        self.albums = albums
    }
    
    func downloadArtworkForAlbum(_ album: Album, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadInProgress[indexPath] {
            return
        }
        
        let downloader = ArtworkDownloader(album: album)
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                self.pendingOperations.downloadInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}

extension AlbumListDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumCell.reuseIdentifier, for: indexPath) as! AlbumCell
        
        let album = albums[indexPath.row]
        let viewModel = AlbumCellViewModel(album: album)
        
        cell.configure(with: viewModel)
        cell.accessoryType = .disclosureIndicator
        
        if album.artworkState == .placeholder {
            downloadArtworkForAlbum(album, atIndexPath: indexPath)
        }
        
        return cell
    }
}

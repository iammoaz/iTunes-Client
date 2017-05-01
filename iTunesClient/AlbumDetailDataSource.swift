//
//  AlbumDetailDataSource.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class AlbumDetailDataSource: NSObject {
    fileprivate var songs: [Song]
    
    init(songs: [Song]) {
        self.songs = songs
        super.init()
    }
    
    func song(at indexPath: IndexPath) -> Song {
        return songs[indexPath.row]
    }
    
    func update(with songs: [Song]) {
        self.songs = songs
    }
}

extension AlbumDetailDataSource: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.reuseIdentifier, for: indexPath) as! SongCell
        let song = songs[indexPath.row]
        let viewModel = SongCellViewModel(song: song)
        cell.configure(with: viewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Tracks"
        default:
            return nil
        }
    }
}

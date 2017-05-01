//
//  AlbumDetailController.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    var album: Album? {
        didSet {
            guard let album = album else { return }
            configure(with: album)
            dataSource.update(with: album.songs)
            tableView.dataSource = dataSource
        }
    }
    
    var dataSource = AlbumDetailDataSource(songs: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        
        albumTitleLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDateLabel.text = viewModel.releaseDate
    }
}

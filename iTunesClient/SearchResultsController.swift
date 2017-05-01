//
//  SearchResultsController.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    private let searchController = UISearchController(searchResultsController: nil)
    fileprivate let dataSource = SearchResultsDataSource()
    fileprivate let client = ItunesAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(self.dismissSearchResultsController))
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = dataSource
        
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
        
    }

    func dismissSearchResultsController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbums" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let artist = dataSource.artist(at: indexPath)
                let albumListController = segue.destination as! AlbumListController
                
                client.lookupArtist(withId: artist.id) { artist, error in
                    albumListController.artist = artist
                    albumListController.tableView.reloadData()
                }
            }
        }
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        client.searchForArtists(withTerm: searchController.searchBar.text!) { [weak self] artists, error in
            self?.dataSource.update(with: artists)
            self?.tableView.reloadData()
        }
    }
}

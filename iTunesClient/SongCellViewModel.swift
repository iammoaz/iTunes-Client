//
//  SongCellViewModel.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

struct SongCellViewModel {
    fileprivate (set) var title: String
    fileprivate (set) var runtime: String
}

extension SongCellViewModel {
    init(song: Song) {
        self.title = song.censoredName
        
        let timeInSeconds = song.trackTime/1000
        let minutes = timeInSeconds/60 % 60
        let seconds = timeInSeconds % 60
        self.runtime = "\(minutes): \(seconds)"
    }
}

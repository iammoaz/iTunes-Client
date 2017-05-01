//
//  SongCell.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/29/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {

    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songRuntimeLabel: UILabel!
    
    static let reuseIdentifier = String(describing: SongCell.self)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(with viewModel: SongCellViewModel) {
        songTitleLabel.text = viewModel.title
        songRuntimeLabel.text = viewModel.runtime
    }
}

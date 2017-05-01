//
//  PendingOperations.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/30/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

class PendingOperations {
    let downloadQueue = OperationQueue()
    var downloadInProgress = [IndexPath: Operation]()
}

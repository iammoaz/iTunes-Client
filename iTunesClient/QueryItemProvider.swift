//
//  QueryItemProvider.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/30/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

protocol QueryItemProvider {
    var queryItem: URLQueryItem { get }
}

//
//  ItunesError.swift
//  iTunesClient
//
//  Created by Muhammad Moaz on 4/30/17.
//  Copyright © 2017 Muhammad Moaz. All rights reserved.
//

import Foundation

enum ItunesError: Error {
    case requestFailed
    case responseUnsuccessful
    case invalidData
    case jsonConversionFailure
    case jsonParsingFailure(message: String)
}

//
//  NetworkError.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case invalidStatusCode(Int)
    case generalError(Error)
}

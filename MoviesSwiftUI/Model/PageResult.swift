//
//  PageResult.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import Foundation

struct PageResult: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case totalPages = "total_pages"
        case totalResults = "total_results"
        case page, results
    }
    
}

struct Movie: Decodable, Hashable {
    let id: Int
    let title: String
    let overview: String
    let imagePath: String?
    let releaseDate: String?
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case imagePath = "poster_path"
        case releaseDate = "release_date"
        case rating = "vote_average"
        case id, title, overview
    }
    
}

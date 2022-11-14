//
//  NetworkParams.swift
//  MoviesWithCombine
//
//  Created by Marcus Washington on 8/16/22.
//

import Foundation

enum NetworkParams {
    case moviesList(page: Int)
    case movieImage(path: String)
            
//https://api.themoviedb.org/3/movie/popular?api_key=705f7bed4894d3adc718c699a8ca9a4f&page=1
    
    var url: URL? {
        switch self {
        case .moviesList(page: let page):
            guard var urlComponents = URLComponents(string: "https://api.themoviedb.org/3/movie/popular") else { return nil }
            
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "api_key", value: "705f7bed4894d3adc718c699a8ca9a4f"))
            queryItems.append(URLQueryItem(name: "language", value: "en-US"))
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            urlComponents.queryItems = queryItems
            
            return urlComponents.url
            
        case .movieImage(path: let path):
            return URL(string: "/t/p/w500\(path)", relativeTo: URL(string: "https://image.tmdb.org"))
        }
    }
    
}

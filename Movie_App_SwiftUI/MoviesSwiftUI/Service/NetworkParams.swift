//
//  NetworkParams.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import Foundation

enum NetworkParams {
    
    private struct NetworkConstants {
        static let popularMoviesBase = "https://api.themoviedb.org/3/movie/popular?api_key=705f7bed4894d3adc718c699a8ca9a4f&page=1"
        static let moviePosterBase = "https://image.tmdb.org/t/p/w500"
    }
    
    case popularMovies(Int)
    case moviePoster(String)
    
    
    var url: URL? {
        switch self {
        case .popularMovies(let page):
            var components = URLComponents(string: NetworkConstants.popularMoviesBase)
            var queryItems: [URLQueryItem] = []
            queryItems.append(URLQueryItem(name: "api_key", value: "705f7bed4894d3adc718c699a8ca9a4f"))
            queryItems.append(URLQueryItem(name: "page", value: "\(page)"))
            components?.queryItems = queryItems
            
            return components?.url
            
            // MARK: Check for '/' in path
        case .moviePoster(let path):
            return URL(string: NetworkConstants.moviePosterBase + path)
        }
    }
    
    
}

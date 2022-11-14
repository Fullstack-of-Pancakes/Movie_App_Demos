//
//  MovieListViewModel.swift
//  MoviesWithCombine
//
//  Created by Marcus Washington on 8/16/22.
//

import Foundation
import Combine

//protocol MovieListViewModelType {
//    func loadMovies()
//    var movies: [Movie] { get }
//}


class MovieListViewModel {
    
    private let networkService: NetworkService
    private var currentPage = 0
    @Published var movies: [Movie] = []
    var subs = Set<AnyCancellable>()
    
    let imageCache = ImageCache()
    @Published var rowRequested = 0
    
    init(networkService: NetworkService = NetworkManager()) {
        self.networkService = networkService
    }
    
    func loadMovies() {
        self.networkService.getModel(url: NetworkParams.moviesList(page: self.currentPage + 1).url)
            .sink { completion in
                print(completion)
            } receiveValue: { (page: PageResult) in
                self.movies.append(contentsOf: page.results)
                self.currentPage = page.page
                print(page.page)
            }.store(in: &self.subs)
    }
    
    func requestImageData(for row: Int) -> Data? {
        guard let path = self.movies[row].imagePath else { return nil }
        if let data = self.imageCache.get(url: path) {
            return data
        }
        
        self.networkService.getRawData(url: NetworkParams.movieImage(path: path).url)
            .sink { completion in
                print(completion)
            } receiveValue: { data in
                self.imageCache.set(data: data, url: path)
                self.rowRequested = row
            }.store(in: &self.subs)

        return nil
    }
    
    
}

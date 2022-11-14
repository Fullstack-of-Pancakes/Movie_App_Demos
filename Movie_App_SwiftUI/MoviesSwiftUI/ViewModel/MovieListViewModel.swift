//
//  MovieListViewModel.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import Foundation
import Combine


protocol MovieListViewModelType: ObservableObject {
    var movies: [Movie] { get }
    var isLoading: Bool { get }
    func requestMoviesIfNeeded(index: Int)
}

class MovieListViewModel: MovieListViewModelType {
    
    private let networkService: NetworkService
    private var subs = Set<AnyCancellable>()
    @Published var movies: [Movie] = []
    var currentPage = 0
    @Published var isLoading: Bool = false
    
    init(network: NetworkService = NetworkManager()) {
        self.networkService = network
        self.requestMoviesIfNeeded(index: 0)
    }
    
    func requestMoviesIfNeeded(index: Int) {
        guard index == (self.movies.count - 1) || self.movies.isEmpty else { return }
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.requestMovies()
        }
    }
    
    func requestMovies() {
        self.networkService.getModel(url: NetworkParams.popularMovies(self.currentPage + 1).url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] (page: PageResult) in
                self?.movies.append(contentsOf: page.results)
                self?.currentPage = page.page
                self?.isLoading = false
            }.store(in: &self.subs)
    }
    
    
}

//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import SwiftUI

struct ContentView<T: MovieListViewModelType>: View {
    
    @ObservedObject var movieListVM: T
    
    var body: some View {
        // TODO: Figure out removing space at top of NavigationView
        NavigationView {
            VStack {
                Text("Movies")
                
                List {
                    ForEach(0..<self.movieListVM.movies.count, id: \.self) { index in
                        NavigationLink(destination: MovieDetailView(movieVM: self.movieListVM, index: index)) {
                            MovieView(movieListVM: self.movieListVM, index: index)
                                .onAppear {
                                    self.movieListVM.requestMoviesIfNeeded(index: index)
                                }
                        }
                    }
                            
                    if self.movieListVM.isLoading {
                        ProgressView()
                    }
                }

            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(movieListVM: MovieListViewModel())
    }
}

//
//  MovieView.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import SwiftUI

struct MovieView<T: MovieListViewModelType>: View {
    
    @ObservedObject var movieListVM: T
    let index: Int
    
    var body: some View {
        HStack {
            AsyncImage(url: NetworkParams.moviePoster(self.movieListVM.movies[index].imagePath ?? "").url) { realImage in
                realImage
                    .resizable()
                    .frame(width: 150, height: 200, alignment: .center)
            } placeholder: {
                ProgressView()
                    .frame(width: 150, height: 200, alignment: .center)
            }
                .padding([.top, .bottom, .trailing], 8)
            Text(movieListVM.movies[index].title)
                .padding([.top, .bottom, .trailing], 8)
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0))
    }
}

struct MovieView_Previews: PreviewProvider {
    static var previews: some View {
        MovieView(movieListVM: MovieListViewModel(), index: 0)
    }
}

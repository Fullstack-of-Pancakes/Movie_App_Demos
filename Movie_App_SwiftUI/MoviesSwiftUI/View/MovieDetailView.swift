//
//  MovieDetailView.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import SwiftUI

struct MovieDetailView<T: MovieListViewModelType>: View {
    @ObservedObject var movieVM: T
    let index: Int
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            MovieView(movieListVM: self.movieVM, index: index)
            Text(self.movieVM.movies[index].overview)
                .padding()
            Spacer()
            Button("Back") {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
            .navigationBarBackButtonHidden(true)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movieVM: MovieListViewModel(), index: 0)
    }
}

//
//  MoviesSwiftUIApp.swift
//  MoviesSwiftUI
//
//  Created by Marcus Washington on 8/18/22.
//

import SwiftUI

@main
struct MoviesSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(movieListVM: MovieListViewModel())
        }
    }
}

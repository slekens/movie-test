//
//  ContentView.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject var moviesModel = MovieViewModel()
    @State private var searchText : String = ""
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search Bar")
                List {
                    ForEach(moviesModel.movies.results.filter {
                        self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                    }, id: \.self) { movie in
                        NavigationLink(destination: MoviewDetailView()) {
                            Text(movie.title)
                        }
                    }
                }.listStyle(PlainListStyle())
                .onAppear {
                    moviesModel.fetchMovies()
                }
            }.navigationBarTitle("Movies", displayMode: .large)
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}

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
    @State private var showingSheet = false
    private var columns: [GridItem] = [
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16),
        GridItem(.fixed(100), spacing: 16)
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search Bar")
                VStack(alignment: .leading) {
                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                            ForEach(moviesModel.movies.filter {
                                self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                            }, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    MovieCardView(movie: movie)
                                        .frame(height: 160)
                                        .onAppear {
                                            if moviesModel.movies.last == movie {
                                                moviesModel.fetchNext()
                                            }
                                        }
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Movies", displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                showingSheet = true
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle.fill")
            })
            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(
                    title: Text("Select a moview category"),
                    buttons: [
                        .default(Text("Popular")) { moviesModel.fetchMovies(.popular)},
                        .default(Text("Top Rated")) { moviesModel.fetchMovies(.topRated)},
                        .default(Text("Upcomming")) { moviesModel.fetchMovies(.upcomming)},
                        .cancel()
                    ]
                )
            }
        }
    }
}

struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}

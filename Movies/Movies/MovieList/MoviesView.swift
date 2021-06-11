//
//  ContentView.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import SwiftUI
/// View for the list of movies
struct MoviesView: View {
    // MARK: - Properties
    @ObservedObject var moviesModel = MovieViewModel()
    @State private var searchText : String = ""
    @State private var showingSheet = false
    let movieCardHeight: CGFloat = 160.0
    private var columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100), spacing: 16),
        GridItem(.adaptive(minimum: 100), spacing: 16),
        GridItem(.adaptive(minimum: 100), spacing: 16)
    ]
    // MARK: - Body View
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    ScrollView(.vertical, showsIndicators: true) {
                        LazyVGrid(columns: columns, alignment: .center, spacing: 16) {
                            Section(header: Text(moviesModel.category.createTitle()).font(.title2)) {
                                ForEach(moviesModel.movies.filter {
                                    self.searchText.isEmpty ? true : $0.title.lowercased().contains(self.searchText.lowercased())
                                }, id: \.id) { movie in
                                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                                        MovieCardView(movie: movie)
                                            .frame(height: movieCardHeight)
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
            }
            .searchable(text: $searchText)
            .navigationBarTitle(moviesModel.viewTitle, displayMode: .large)
            .navigationBarItems(trailing: Button(action: {
                showingSheet = true
            }) {
                Image(systemName: "line.horizontal.3.decrease.circle.fill")
            })
            .actionSheet(isPresented: $showingSheet) {
                ActionSheet(
                    title: Text("LABEL_SHEET_TITLE"),
                    buttons: [
                        .default(Text("LABEL_SHEET_OPTION_POPULAR")) { moviesModel.fetchMovies(.popular)},
                        .default(Text("LABEL_SHEET_OPTION_TOP_RATED")) { moviesModel.fetchMovies(.topRated)},
                        .default(Text("LABEL_SHEET_OPTION_UPCOMMING")) { moviesModel.fetchMovies(.upcomming)},
                        .cancel()
                    ]
                )
            }
        }
    }
}
// MARK: - Preview
#if DEBUG
struct MoviesView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
    }
}
#endif

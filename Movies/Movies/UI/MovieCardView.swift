//
//  MovieListView.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//
import SwiftUI
/// Movie view for the main view.
struct MovieCardView: View {
    // MARK: - Properties
    var movie: Movie
    // MARK: - Body view
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let poster = movie.poster {
                AsyncImage(url: MovieAPI.createURL(posterSize: .small, imageName: poster)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                    case .failure:
                        PlaceholderMovieView()
                    case .empty:
                        LoadingView()
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                PlaceholderMovieView()
            }
        }
        .aspectRatio(contentMode: .fit)
        .cornerRadius(10)
        .shadow(radius: 10)
    }
}
// MARK: Preview
#if DEBUG
struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie(poster: "avengers", movieID: 12345, title: "Aquaman", overview: "Set before the events of ‘Soul’, 22 refuses to go to Earth, enlisting a gang of 5 new souls in attempt of rebellion. However, 22’s subversive plot leads to a surprising revelation about the meaning of life.", popularity: 800.35, voteCount: 100, voteAverage: 60))
    }
}
#endif

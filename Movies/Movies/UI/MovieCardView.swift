//
//  MovieListView.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//

import SwiftUI

struct MovieCardView: View {
    var movie: Movie
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: movie.createURL(),
                       placeholder: { Text("Loading ...") },
                       image: {
                        Image(uiImage: $0)
                            .resizable()
                       })
                .cornerRadius(10)
                .shadow(radius: 10)
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieCardView(movie: Movie(poster: "avengers", movieID: 12345, title: "Aquaman", overview: "Set before the events of ‘Soul’, 22 refuses to go to Earth, enlisting a gang of 5 new souls in attempt of rebellion. However, 22’s subversive plot leads to a surprising revelation about the meaning of life.", popularity: 800.35, voteCount: 100, voteAverage: 60))
    }
}

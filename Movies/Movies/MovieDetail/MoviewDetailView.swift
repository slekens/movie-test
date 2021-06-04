//
//  MoviewDetailView.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import SwiftUI

struct MoviewDetailView: View {
    var movie: Movie
    var body: some View {
        NavigationView {
            ZStack {
                AsyncImage(url: movie.createURL(), placeholder: { Text("Loading ...") })

            VStack {
                Text(movie.title)
                    .font(.title)
                Text(movie.overview)
                    .font(.body)
            }
                .navigationBarTitle("Detail", displayMode: .large)
        }
        }
    }
}

struct MoviewDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MoviewDetailView(movie: Movie(poster: "avengers", movieID: 12345, title: "Aquaman", overview: "Set before the events of ‘Soul’, 22 refuses to go to Earth, enlisting a gang of 5 new souls in attempt of rebellion. However, 22’s subversive plot leads to a surprising revelation about the meaning of life.", popularity: 800.35, voteCount: 100, voteAverage: 60))
    }
}

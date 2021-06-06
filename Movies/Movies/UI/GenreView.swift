//
//  TagList.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import SwiftUI
/// Genre tag list view for movie detail view.
struct GenreView: View {
    // MARK: - Properties
    var genres: [MovieGenre]
    let geometry: GeometryProxy
    //  MARK: - Body view
    var body: some View {
        self.generateContent(in: geometry)
    }
    // MARK: - Private functions
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        return ZStack(alignment: .topLeading) {
            ForEach(self.genres, id: \.self) { genre in
                self.item(for: genre.name)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if genre == self.genres.first! {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if genre == self.genres.first! {
                            height = 0
                        }
                        return result
                    })
            }
        }
    }
    private func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(Color.init(.systemBlue))
            .foregroundColor(Color.white)
            .cornerRadius(15)
    }
}

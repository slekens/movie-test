//
//  CastView.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import SwiftUI
/// Cast View
struct CastView: View {
    // MARK: - Properties.
    var castList: [Cast]
    // MARK: - Body View
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(castList, id: \.id) { cast in
                    HStack(alignment: .top) {
                        if let profilePicture = cast.profilePicture {
                            AsyncImage(url: MovieAPI.createURL(posterSize: .cast, imageName: profilePicture)) { phase in
                                switch phase {
                                case .success(let image):
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                case .failure:
                                    PlaceholderMovieView()
                                case .empty:
                                    LoadingView()
                                @unknown default:
                                    EmptyView()
                                }
                            }
                                .frame(width: 80, height: 80, alignment: .center)
                                .cornerRadius(100)
                                .clipped()
                                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                        } else {
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 80, height: 80, alignment: .center)
                                .cornerRadius(100)
                                .clipped()
                                .shadow(color: .gray, radius: 10, x: 0.0, y: 0.0)
                        }
                        VStack(alignment: .leading) {
                            Text(cast.name)
                                .font(.headline)
                            Text(cast.character)
                                .font(.callout)
                        }
                    }
                    .padding()
                }
            }.padding()
        }
    }
}
// MARK: - Preview
#if DEBUG
struct CastView_Previews: PreviewProvider {
    static var previews: some View {
        CastView(castList: [
                    Cast(id: 1, name: "Emma Stone", character: "Emma Stone", profilePicture: "avengers"),
                    Cast(id: 2, name: "Emma Stone", character: "Emma Stone", profilePicture: "avengers"),
                    Cast(id: 3, name: "Emma Stone", character: "Emma Stone", profilePicture: "avengers")
        ])
    }
}
#endif

//
//  PlaceholderMovieView.swift
//  Movies
//
//  Created by Abraham Abreu on 05/06/21.
//

import SwiftUI
/// This a simply view to show a placeholder if image movie fails to load or is missing.
struct PlaceholderMovieView: View {
    // MARK: - Body View
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.init(.systemGray4))
            Image(systemName: "film")
                .resizable()
                .padding()
                .frame(width: 80, height: 80, alignment: .center)
        }
    }
}
// MARK: Preview
#if DEBUG
struct PlaceholderMovieView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceholderMovieView()
    }
}
#endif

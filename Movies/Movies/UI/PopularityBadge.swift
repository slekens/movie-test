//
//  PopularityBadge.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import SwiftUI
/// This is a view for show a metter based on the average vote form a movie.
public struct PopularityBadge : View {
    // MARK: - Properties.
    public let score: Int
    public let textColor: Color
    @State private var isDisplayed = false
    private var scoreColor: Color {
        get {
            if score < 40 {
                return .red
            } else if score < 60 {
                return .orange
            } else if score < 75 {
                return .yellow
            }
            return .green
        }
    }
    // MARK: - Initialization.
    public init(score: Int, textColor: Color = .primary) {
        self.score = score
        self.textColor = textColor
    }
    // MARK: - Private functions.
    private var overlay: some View {
        ZStack {
            Circle()
                .trim(from: 0,
                      to: isDisplayed ? CGFloat(score) / 100 : 0)
                .stroke(style: StrokeStyle(lineWidth: 2, dash: [1]))
                .foregroundColor(scoreColor)
                .animation(Animation.interpolatingSpring(stiffness: 60, damping: 10).delay(0.1))
        }
        .rotationEffect(.degrees(-90))
        .onAppear {
            self.isDisplayed = true
        }
    }
    // MARK: - Body View
    public var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.clear)
                .frame(width: 40)
                .overlay(overlay)
                .shadow(color: scoreColor, radius: 4)
            Text("\(score)%")
                .font(Font.system(size: 10))
                .fontWeight(.bold)
                .foregroundColor(textColor)
            }
            .frame(width: 40, height: 40)
    }
}
// MARK: - Preview
#if DEBUG
struct PopularityBadge_Previews : PreviewProvider {
    static var previews: some View {
        VStack {
            PopularityBadge(score: 10)
        }
    }
}
#endif

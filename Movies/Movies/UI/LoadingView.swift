//
//  LoadingView.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import SwiftUI

struct LoadingView: View {
 
    @State private var isLoading = false
 
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray3), lineWidth: 8)
                .frame(width: 30, height: 30)
            Circle()
                .trim(from: 0, to: 0.2)
                .stroke(Color.blue, lineWidth: 5)
                .frame(width: 30, height: 30)
                .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                .onAppear() {
                    self.isLoading = true
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

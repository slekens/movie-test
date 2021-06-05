//
//  BlurBackground.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import SwiftUI

struct BlurBackground : UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView{
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemMaterial))
        return view
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) { }
}

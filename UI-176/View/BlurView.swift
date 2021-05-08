//
//  BlurView.swift
//  UI-176
//
//  Created by にゃんにゃん丸 on 2021/05/08.
//

import SwiftUI

struct BlurView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIVisualEffectView {
        
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemChromeMaterial))
        
        return view
        
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        
    }
}


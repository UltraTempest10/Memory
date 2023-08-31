//
//  PanoramaView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import SwiftUI
import CTPanoramaView

struct PanoramaView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let panoramaView = CTPanoramaView()
        panoramaView.image = panoramaImage
        panoramaView.controlMethod = .both
        panoramaView.startAngle = 180
        let viewController = panoramaView
        return viewController
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

struct PanoramaView_Previews: PreviewProvider {
    static var previews: some View {
        PanoramaView()
    }
}

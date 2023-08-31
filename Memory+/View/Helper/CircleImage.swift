//
//  CircleImage.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/20.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 80, height: 80)
            .background(
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipped()
            )
            .cornerRadius(80)
            .overlay(
                RoundedRectangle(cornerRadius: 80)
                    .inset(by: 1)
                    .stroke(.white, lineWidth: 2)
            )
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("avatar"))
    }
}

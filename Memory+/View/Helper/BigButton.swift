//
//  BigButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/19.
//

import SwiftUI

struct BigButton: View {
    var text: String
    var image = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.067)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: Color(red: 0.04, green: 0.15, blue: 0.53), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.21, green: 0.34, blue: 0.78).opacity(0.79), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0, y: 0.5),
                        endPoint: UnitPoint(x: 1, y: 0.5)
                    )
                )
                .cornerRadius(28)
                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
            HStack {
                if image != "" {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 32, height: 32)
                        .background(
                            Image(image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 32, height: 32)
                                .clipped()
                        )
                }
                Text(text)
                    .font(
                        Font.custom("PingFang SC", size: 24)
                            .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
    }
}

struct BigButton_Previews: PreviewProvider {
    static var previews: some View {
        BigButton(text: "关键词AI生成", image: "AI")
    }
}

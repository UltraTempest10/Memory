//
//  SmallButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/19.
//

import SwiftUI

struct SmallButton: View {
    var isDisabled: Bool = false
    var text: String
    
    var body: some View {
        ZStack {
            if isDisabled {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width * 0.307, height: UIScreen.main.bounds.height * 0.04)
                    .background(Constants.lightGray)
                    .cornerRadius(51)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
                Text(text)
                    .font(
                        Font.custom("PingFang SC", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
            }
            else {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width * 0.307, height: UIScreen.main.bounds.height * 0.04)
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
                    .cornerRadius(51)
                    .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
                Text(text)
                    .font(
                        Font.custom("PingFang SC", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
    }
}

struct SmallButton_Previews: PreviewProvider {
    static var previews: some View {
        SmallButton(text: "选择")
    }
}

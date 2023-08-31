//
//  KeywordButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/20.
//

import SwiftUI

struct KeywordButton: View {
    var text: String
    var index: Int
    @Binding var selectedButton: Int
    
    var body: some View {
        Button {
            selectedButton = index
        } label: {
            ZStack {
                Rectangle()
                    .padding(.horizontal, 10)
                    .padding(.vertical, 2)
                    .frame(width: 108, height: 29, alignment: .center)
                    .foregroundColor(.clear)
                    .background(selectedButton == index ? Constants.lightGray : .white)
                    .cornerRadius(4)
                    .shadow(color: .black.opacity(0.2), radius: 1, x: 1, y: 1)
                Text(text)
                    .font(
                        Font.custom("PingFang SC", size: 18)
                            .weight(.medium)
                    )
                    .foregroundColor(Constants.darkGray)
            }
        }
    }
}

struct KeywordButton_Previews: PreviewProvider {
    static var previews: some View {
        KeywordButton(text: "", index: 0, selectedButton: .constant(0))
    }
}

//
//  PhotoButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/31.
//

import SwiftUI

struct PhotoButton: View {
    var index: Int
    @Binding var selectedButton: Int
    
    var body: some View {
        Button {
            selectedButton = index
        } label: {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.width * 0.32)
                    .background(.clear)
                VStack {
                    HStack {
                        Spacer()
                        Image(selectedButton == index ? "selected" : "circle")
                    }
                    .padding(.trailing, 6.0)
                    Spacer()
                }
                .padding(.top, 6.0)
                .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.width * 0.32)
            }
        }
    }
}

struct PhotoButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotoButton(index: 0, selectedButton: .constant(0))
    }
}

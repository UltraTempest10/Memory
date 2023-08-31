//
//  ChatView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/31.
//

import SwiftUI

struct ChatView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var title: String = "聊天"
    @State var text: String = ""
    
    var body: some View {
        VStack {
            Image("Rectangle 2980")
                .resizable()
                .scaledToFit()
            Spacer()
            TextField("", text: $text)
                .padding(.leading, 10)
                .frame(width: UIScreen.main.bounds.width * 0.888, height: 41)
                .background(.white)
                .cornerRadius(6)
                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
        }
        .padding(.bottom)
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
            }
            ToolbarItem(placement: .principal) {
                Text(title)
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

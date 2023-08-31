//
//  ChatList.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/20.
//

import SwiftUI

struct ChatList: View {
    @Binding var loginState: Int
    
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                Text("快速聊天")
                    .font(
                        Font.custom("PingFang SC", size: 24)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                    Spacer()
            }
            .padding(.horizontal)
            ZStack {
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.123)
                    .background(.white)
                    .foregroundColor(.white)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                if loginState == 1 {
                    ScrollView(.horizontal) {
                        HStack{
                            ForEach(followList.indices,  id: \.self) { index in
                                NavigationLink {
                                    ChatView(title: followList[index].nickname)
                                } label: {
                                    VStack {
                                        Rectangle()
                                            .foregroundColor(.clear)
                                            .frame(width: 60, height: 60)
                                            .background(
                                                Image(uiImage: followList[index].avatar ?? UIImage())
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 60, height: 60)
                                                    .clipped()
                                            )
                                            .cornerRadius(60)
                                            .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                                        Text(followList[index].nickname)
                                            .font(
                                                Font.custom("PingFang SC", size: 16)
                                                    .weight(.medium)
                                            )
                                            .foregroundColor(Constants.gray)
                                            .frame(width: 60)
                                            .lineLimit(1)
                                    }
                                    .padding(.all, 8.0)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct ChatList_Previews: PreviewProvider {
    static var previews: some View {
        ChatList(loginState: .constant(1))
    }
}

//
//  PostBlock.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/28.
//

import SwiftUI

struct PostBlock: View {
    @State var post: Post
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
            VStack {
                Image(uiImage: post.picture)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height * 0.177)
                    .clipped()
                HStack {
                    Text(post.title)
                        .font(
                            Font.custom("PingFang SC", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    Spacer()
                    LikeButton(post: $post)
                }
                .padding(.horizontal)
                HStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 44, height: 44)
                        .background(
                            Image(uiImage: post.avatar)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 44, height: 44)
                                .clipped()
                        )
                        .cornerRadius(44)
                        .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                    VStack(alignment: .leading) {
                        Text(post.creator)
                            .font(
                                Font.custom("PingFang SC", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                        Text(post.sincePost)
                            .font(
                                Font.custom("PingFang SC", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.34, green: 0.34, blue: 0.34))
                    }
                    Spacer()
                }
                .padding([.leading, .bottom, .trailing])
            }
            .frame(width: UIScreen.main.bounds.width * 0.446, height: UIScreen.main.bounds.height * 0.286)
            .cornerRadius(10)
        }
        .frame(width: UIScreen.main.bounds.width * 0.446, height: UIScreen.main.bounds.height * 0.286)
    }
}

struct PostBlock_Previews: PreviewProvider {
    static var previews: some View {
        PostBlock(post: Post())
    }
}

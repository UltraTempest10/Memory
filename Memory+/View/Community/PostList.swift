//
//  PostList.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/30.
//

import SwiftUI

struct PostList: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var loginState: Int
    @State var posts: [Post] = postArray
    
    var body: some View {
        VStack(spacing: 1) {
            HStack {
                Text("关注推荐")
                    .font(
                        Font.custom("PingFang SC", size: 24)
                            .weight(.medium)
                    )
                    .foregroundColor(.black)
                Spacer()
                Button {
                    loadPostData()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        posts = postArray
                    }
                } label: {
                    Image("renew1")
                        .resizable()
                        .frame(width: 16, height: 16)
                        .clipped()
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack {
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .opacity(0)
                    ForEach(posts) { post in
                        NavigationLink {
                            PostDetail(loginState: loginState, post: post)
                        } label: {
                            PostBlock(post: post)
                        }
                    }
                    Rectangle()
                        .frame(width: 10, height: 1)
                        .opacity(0)
                }
                .padding(.bottom)
            }
        }
//        .onAppear {
//            loadPostData()
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//                posts = postArray
//            }
//        }
    }
}

struct PostList_Previews: PreviewProvider {
    static var previews: some View {
        PostList(loginState: .constant(0))
    }
}

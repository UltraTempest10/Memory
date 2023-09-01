//
//  LikeView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/9/1.
//

import SwiftUI

struct LikeView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var loginState: Int
    @State var posts = likeArray
    
    var body: some View {
        ZStack {
            VStack {
                Image("Rectangle 2975")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.159)
                Spacer()
            }
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: UIScreen.main.bounds.height * 0.115)
                List {
                    ForEach(posts) { post in
                        NavigationLink {
                            PostDetail(loginState: loginState, post: post)
                        } label: {
                            MemoryRow(memory: post, small: true)
                        }
                    }
                }
                .listStyle(.plain)
                .background(Constants.bgColor)
                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
            }
        }
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
                Text("点赞列表")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                posts = likeArray
            }
        }
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView(loginState: .constant(1))
    }
}

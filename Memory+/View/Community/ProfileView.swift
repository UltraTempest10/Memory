//
//  ProfileView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/9/1.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var loginState = UserDefaults.standard.integer(forKey: "isLoggedIn")
    @State var user: Profile
    @State var posts: [Post] = []
    
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
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: UIScreen.main.bounds.height * 0.14)
                        .background(.white)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                    HStack {
                        VStack(alignment: .leading) {
                            Text(user.nickname)
                                .font(
                                    Font.custom("PingFang SC", size: 29)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                            Text(user.signature)
                                .font(
                                    Font.custom("PingFang SC", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.gray)
                        }
                        Spacer()
                        CircleImage(image: Image(uiImage: user.avatar!))
                    }
                    .padding(.horizontal)
                }
                ScrollView {
                    ForEach(posts) { post in
                        NavigationLink {
                            PostDetail(loginState: loginState, post: post)
                        } label: {
                            MemoryRow(memory: post)
                        }
                    }
                }
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
                Text("个人主页")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            loadUserPostData(user: user)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                posts = userPosts
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                posts = userPosts
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                posts = userPosts
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(user: Profile())
    }
}

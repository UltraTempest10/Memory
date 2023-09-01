//
//  CommunityView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/20.
//

import SwiftUI

struct CommunityView: View {
    let loginController = LoginController()
    @Binding var loginState: Int

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
                ProfileBoard()
                ChatList(loginState: $loginState)
                PostList(loginState: $loginState)
                Spacer()
            }
            .padding(.bottom, 16.0)
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.751)
            .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
        }
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    loginController.logout()
                    UserDefaults.standard.set(0, forKey: "isLoggedIn")
                    loginState = 0
                    profile = Profile()
                    memories.posts.removeAll()
                } label: {
                    Image("logout")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("我的")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {

                } label: {
                    Image("message")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
            }
        }
    }
}

struct CommunityView_Previews: PreviewProvider {
    static var previews: some View {
        CommunityView(loginState: .constant(0))
    }
}

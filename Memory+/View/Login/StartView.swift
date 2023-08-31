//
//  StartView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/26.
//

import SwiftUI

struct StartView: View {
    @Binding var loginState: Int
    
    var body: some View {
        ZStack {
            Image("welcome")
                .resizable()
                .scaledToFill()
            VStack {
                Spacer()
                NavigationLink {
                    RegisterView(loginState: $loginState)
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.067)
                            .background(Color.white)
                            .cornerRadius(28)
                            .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                        Text("注册")
                            .font(
                                Font.custom("PingFang SC", size: 24)
                                    .weight(.bold)
                            )
                            .foregroundColor(Constants.accentColor)
                    }
                }
                .padding(.bottom)
                NavigationLink {
                    LoginView(loginState: $loginState)
                } label: {
                    BigButton(text: "登录")
                }
                Button {
                    UserDefaults.standard.set(2, forKey: "isLoggedIn")
                    loginState = 2
                } label: {
                    Text("跳过")
                        .font(
                            Font.custom("PingFang SC", size: 19)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Constants.lightGray)
                }
                .padding(.top, 50.0)
            }
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .frame(height: UIScreen.main.bounds.height * 0.9)
        }
        .ignoresSafeArea()
        .onChange(of: loginState) { newValue in
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(loginState: .constant(0))
    }
}

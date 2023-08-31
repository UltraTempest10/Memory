//
//  LoginView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/20.
//

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    let loginController = LoginController()
    @Binding var loginState: Int
    @State private var showAlert = false
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View {
        ZStack {
            Image("login")
                .resizable()
                .scaledToFill()
            VStack {
                TextBar(placeholder: "请输入用户名", text: $username)
                    .padding(.bottom)
                SecureBar(placeholder: "请输入密码", text: $password)
                    .padding(.bottom, 60.0)
                Button {
                    loginController.signin(username: username, password: password) { (success, error) in
                        if success {
                            // handle successful login
                            UserDefaults.standard.set(1, forKey: "isLoggedIn")
                            presentationMode.wrappedValue.dismiss()
                            loginState = 1
                            loadProfileData()
                        } else {
                            // handle login error
                            showAlert = true
                        }
                }
                } label: {
                    BigButton(text: "登录")
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("登录失败"), message: Text("请检查用户名和密码并重试。"), dismissButton: .default(Text("OK")))
                }
                Button {
                    UserDefaults.standard.set(2, forKey: "isLoggedIn")
                    presentationMode.wrappedValue.dismiss()
                    loginState = 2
                } label: {
                    Text("去逛逛")
                        .font(
                            Font.custom("PingFang SC", size: 19)
                                .weight(.medium)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Constants.darkGray)
                }
            }
            .padding(.top, 200.0)
            .frame(height: UIScreen.main.bounds.height * 0.35)
        }
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
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginState: .constant(0))
    }
}

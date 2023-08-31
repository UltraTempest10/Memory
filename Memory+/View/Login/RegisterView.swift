//
//  RegisterView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/26.
//

import SwiftUI

struct RegisterView: View {
    @Environment(\.presentationMode) var presentationMode
    let loginController = LoginController()
    @Binding var loginState: Int
    @State private var showAlert = false
    @State private var condition = 0
    @State var username: String = ""
    @State var password: String = ""
    @State var passwordCheck: String = ""
    
    var body: some View {
        ZStack {
            Image("register")
                .resizable()
                .scaledToFill()
            VStack {
                TextBar(placeholder: "请输入用户名", text: $username)
                    .padding(.bottom)
                SecureBar(placeholder: "请输入密码", text: $password)
                    .padding(.bottom)
                SecureBar(placeholder: "请再次输入密码", text: $passwordCheck)
                    .padding(.bottom, 40.0)
                Button {
                    if password == passwordCheck {
                        loginController.signup(username: username, password: password) { (success, error) in
                            if success {
                                // handle successful login
                                UserDefaults.standard.set(1, forKey: "isLoggedIn")
                                UserDefaults.standard.set(username, forKey: "username")
                                presentationMode.wrappedValue.dismiss()
                                loginState = 1
                                loadProfileData()
                            } else {
                                // handle login error
                                showAlert = true
                                condition = 1
                            }
                        }
                    } else {
                        showAlert = true
                    }
                } label: {
                    BigButton(text: "注册")
                }
                .alert(isPresented: $showAlert) {
                    if condition == 0 {
                        return Alert(title: Text("两次密码不一致"), message: Text("请检查后重试。"), dismissButton: .default(Text("OK")))
                    } else {
                        return Alert(title: Text("注册失败"), message: Text("请更换用户名或密码后重试。"), dismissButton: .default(Text("OK")))
                    }
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

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(loginState: .constant(0))
    }
}

//
//  HomeView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/19.
//

import SwiftUI

struct HomeView: View {
    @State var info = profile
    var isLoggedIn = UserDefaults.standard.integer(forKey: "isLoggedIn")
    
    var body: some View {
        VStack {
            ZStack {
                Image("Rectangle 2970")
                    .resizable()
                    .scaledToFill()
                VStack(spacing: 8) {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Hello，" + (isLoggedIn == 2 ? "游客" : info.nickname))
                                .font(
                                    Font.custom("PingFang SC", size: 28)
                                        .weight(.bold)
                                )
                                .foregroundColor(.white)
                                .frame(width: 230, height: 37, alignment: .topLeading)
                            Text("回忆你的专属时光！")
                                .font(
                                    Font.custom("PingFang SC", size: 20)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white)
                                .frame(width: 230, height: 37, alignment: .topLeading)
                        }
                        Spacer()
                        CircleImage(image: Image(uiImage: info.avatar!))
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
            .frame(height: UIScreen.main.bounds.height * 0.233)
            VStack {
                HStack {
                    Text("智能推荐")
                        .font(
                            Font.custom("PingFang SC", size: 24)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
//                        .frame(width: 109, height: 25, alignment: .topLeading)
                    Spacer()
                }
                HStack(spacing: 20) {
                    PhotoBlock(index: 0, photo: UIImage(named: "dorm") ?? UIImage(), title: "老工厂宿舍")
                    PhotoBlock(index: 1, photo: UIImage(named: "workshop") ?? UIImage(), title: "老房子的房间")
                }
                .padding(.bottom)
                NavigationLink {
                    KeywordView()
                } label: {
                    BigButton(text: "关键词AI生成", image: "AI")
                }
                NavigationLink {
                    PhotoView()
                } label: {
                    BigButton(text: "使用我的旧照", image: "photo")
                }
            }
            .padding([.top, .leading, .trailing])
            Spacer()
        }
//        .frame(width: 375, height: 812)
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
                } label: {
                    Image("menu")
                        .frame(width: 17, height: 14.73333)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("Memory+")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                info = Profile()
                info = profile
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

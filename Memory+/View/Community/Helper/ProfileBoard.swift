//
//  ProfileBoard.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/20.
//

import SwiftUI

struct ProfileBoard: View {
    @EnvironmentObject var modelData: ModelData
    var isLoggedIn = UserDefaults.standard.integer(forKey: "isLoggedIn")
    @State var info = profile
    @State var edited = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: UIScreen.main.bounds.height * 0.19)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
            VStack {
                if isLoggedIn == 1 {
                    NavigationLink {
                        ProfileEditView(edited: $edited)
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(isLoggedIn == 2 ? "游客" : info.nickname)
                                    .font(
                                        Font.custom("PingFang SC", size: 29)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.black)
                                Text(info.signature)
                                    .font(
                                        Font.custom("PingFang SC", size: 14)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(Constants.gray)
                            }
                            Spacer()
                            CircleImage(image: Image(uiImage: info.avatar!))
                        }
                    }
                } else {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(isLoggedIn == 2 ? "游客" : info.nickname)
                                .font(
                                    Font.custom("PingFang SC", size: 29)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                            Text(info.signature)
                                .font(
                                    Font.custom("PingFang SC", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.gray)
                        }
                        Spacer()
                        CircleImage(image: Image(uiImage: info.avatar!))
                    }
                }
                HStack {
                    VStack {
                        if info.favoriteCount >= 10000 {
                            Text(String(format: "%.1f", Double(info.favoriteCount) / 10000.0) + "万")
                                .font(
                                    Font.custom("PingFang SC", size: 18)
                                        .weight(.bold)
                                )
                        }
                        else {
                            Text("\(info.favoriteCount)")
                                .font(
                                    Font.custom("PingFang SC", size: 18)
                                        .weight(.bold)
                                )
                        }
                        Text("收藏")
                            .font(
                                Font.custom("PingFang SC", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.gray)
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        if info.likeCount >= 10000 {
                            Text(String(format: "%.1f", Double(info.likeCount) / 10000.0) + "万")
                                .font(
                                    Font.custom("PingFang SC", size: 18)
                                        .weight(.bold)
                                )
                        }
                        else {
                            Text("\(info.likeCount)")
                                .font(
                                    Font.custom("PingFang SC", size: 18)
                                        .weight(.bold)
                                )
                        }
                        Text("点赞")
                            .font(
                                Font.custom("PingFang SC", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.gray)
                    }
                    .frame(maxWidth: .infinity)
                    VStack {
                        if info.followCount >= 10000 {
                            Text(String(format: "%.1f", Double(info.followCount) / 10000.0) + "万")
                                .font(
                                    Font.custom("PingFang SC", size: 18)
                                        .weight(.bold)
                                )
                        }
                        else {
                            Text("\(info.followCount)")
                                .font(
                                    Font.custom("PingFang SC", size: 18)
                                        .weight(.bold)
                                )
                        }
                        Text("关注")
                            .font(
                                Font.custom("PingFang SC", size: 14)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                info = Profile()
                info = profile
            }
        }
        .onChange(of: edited) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                info = Profile()
                info = profile
            }
        }
    }
}

struct ProfileBoard_Previews: PreviewProvider {
    static var previews: some View {
        ProfileBoard()
            .environmentObject(ModelData())
    }
}

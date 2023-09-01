//
//  PostDetail.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/30.
//

import SwiftUI
import AVFoundation

struct PostDetail: View {
    @Environment(\.presentationMode) var presentationMode

    var loginState: Int
    @State private var showLoginAlert = false
    @State private var showSelfAlert = false
    
    @State var post: Post
    
    var body: some View {
        ZStack {
            VStack {
                Image(uiImage: post.picture)
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.617)
                    .clipped()
                Spacer()
            }
            VStack {
                if !post.voiceTexts.isEmpty {
                    LazyVStack(spacing: 10) {
                        ForEach(post.voiceTexts.indices, id: \.self) { index in
                            let text = post.voiceTexts[index]
                            HStack {
                                Button {
                                    let url = post.voiceURLs[index]
                                    let playerItem = AVPlayerItem(url: URL(string: url)!)
                                    voicePlayer = AVPlayer(playerItem: playerItem)
                                    voicePlayer?.play()
                                } label: {
                                    VoiceRow(text: text)
                                }
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
                ZStack {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: UIScreen.main.bounds.height * 0.397)
                        .background(.white)
                        .cornerRadius(14)
                    VStack(spacing:20) {
                        HStack {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 58, height: 58)
                                .background(
                                    Image(uiImage: post.avatar)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 58, height: 58)
                                        .clipped()
                                )
                                .cornerRadius(58)
                            Text(post.creator)
                                .font(
                                    Font.custom("PingFang SC", size: 20)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                            Spacer()
                            if loginState == 1 {
                                if post.creatorUsername != profile.username {
                                    FollowButton(post: $post)
                                } else {
                                    Button {
                                        showSelfAlert = true
                                    } label: {
                                        Text("关注")
                                            .font(
                                                Font.custom("PingFang SC", size: 14)
                                                    .weight(.medium)
                                            )
                                            .foregroundColor(.black)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 3.0)
                                            .background(
                                                Capsule()
                                                    .fill(Color.clear)
                                                    .overlay(
                                                        Capsule()
                                                            .stroke(Color.black, lineWidth: 2)
                                                    )
                                            )
                                    }
                                    .alert(isPresented: $showSelfAlert) {
                                        Alert(title: Text("关注失败"), message: Text("您不可以关注自己。"), dismissButton: .default(Text("OK")))
                                    }
                                }
                            } else {
                                Button {
                                    showLoginAlert = true
                                } label: {
                                    Text("关注")
                                        .font(
                                            Font.custom("PingFang SC", size: 14)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.black)
                                        .padding(.horizontal, 16)
                                        .padding(.vertical, 3.0)
                                        .background(
                                            Capsule()
                                                .fill(Color.clear)
                                                .overlay(
                                                    Capsule()
                                                        .stroke(Color.black, lineWidth: 2)
                                                )
                                        )
                                }
                                .alert(isPresented: $showLoginAlert) {
                                    Alert(title: Text("尚未登录"), message: Text("登录后即可进行互动。"), dismissButton: .default(Text("OK")))
                                }
                            }
                        }
                        HStack {
                            Text(post.title)
                                .font(
                                    Font.custom("PingFang SC", size: 23)
                                        .weight(.bold)
                                )
                                .foregroundColor(.black)
                                .padding(.trailing)
                            Spacer()
                            if loginState == 1 {
                                LikeButton(post: $post)
                            } else {
                                Button {
                                    showLoginAlert = true
                                } label: {
                                    Label("Toggle Like"/*for VoiceOver*/, systemImage: "heart")
                                        .labelStyle(.iconOnly)
                                        .foregroundColor(.gray)
                                }
                                .alert(isPresented: $showLoginAlert) {
                                    Alert(title: Text("尚未登录"), message: Text("登录后即可进行互动。"), dismissButton: .default(Text("OK")))
                                }
                            }
                            Text("点赞")
                                .font(
                                    Font.custom("PingFang SC", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                            if loginState == 1 {
                                FavoriteButton(post: $post)
                            } else {
                                Button {
                                    showLoginAlert = true
                                } label: {
                                    Label("Toggle Favorite"/*for VoiceOver*/, systemImage: "star")
                                        .labelStyle(.iconOnly)
                                        .foregroundColor(.gray)
                                }
                                .alert(isPresented: $showLoginAlert) {
                                    Alert(title: Text("尚未登录"), message: Text("登录后即可进行互动。"), dismissButton: .default(Text("OK")))
                                }
                            }
                            Text("收藏")
                                .font(
                                    Font.custom("PingFang SC", size: 14)
                                        .weight(.medium)
                                )
                                .foregroundColor(.black)
                        }
                        ScrollView {
                            Text(post.content)
                                .font(
                                    Font.custom("PingFang SC", size: 16)
                                        .weight(.medium)
                                )
                                .foregroundColor(Color(red: 0.34, green: 0.34, blue: 0.34))
                                .multilineTextAlignment(.leading)
                        }
                        Spacer()
                    }
                    .padding([.top, .leading, .trailing])
                }
                .frame(height: UIScreen.main.bounds.height * 0.397)
            }
            .padding(.top, UIScreen.main.bounds.height * 0.164)
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .background(.clear)
                            .foregroundColor(.black.opacity(0.5))
                            .frame(height: 25)
                        Image(systemName: "chevron.backward")
                            .foregroundColor(.white)
                            .frame(width: 10, height: 20)
                    }
                }
            }
            ToolbarItem(placement: .principal) {
                if let index = musicArray.firstIndex(where: { $0.id == post.musicId }) {
                    MusicBar(index: index)
                }
            }
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(loginState: 0, post: Post())
    }
}

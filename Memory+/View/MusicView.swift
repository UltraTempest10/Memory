//
//  MusicView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/20.
//

import SwiftUI
import UIKit

struct MusicView: View {
    @Environment(\.presentationMode) var presentationMode
    var mode: Int
    var image: UIImage
    var title: String
    @Binding var selectedIndex: Int?
    @State var keyword = ""
    
    var body: some View {
        ZStack {
            VStack {
//                Image(uiImage: image)
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
            }
            VStack {
                Spacer()
                VStack {
                    HStack {
                        Text("为你的场景添加音乐")
                            .font(
                                Font.custom("PingFang SC", size: 24)
                                    .weight(.medium)
                            )
                        .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(.horizontal)
                    SearchBar(placeholder: "输入关键词", keyword: $keyword)
                        .padding(.bottom)
                    ZStack {
                        VStack {
                            HStack {
                                Text("推荐音乐")
                                    .font(
                                        Font.custom("PingFang SC", size: 24)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.black)
                                Spacer()
                                if selectedIndex != nil {
                                    Text("已选择：\(musicArray[selectedIndex!].title)-\(musicArray[selectedIndex!].artist)")
                                        .font(
                                            Font.custom("PingFang SC", size: 16)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.black)
                                        .lineLimit(1)
                                        .frame(width: UIScreen.main.bounds.width * 0.45)
                                }
                            }
                            .padding(.horizontal)
                            List {
                                ForEach(musicArray.indices, id: \.self) { index in
                                    MusicRow(index: index, selectedIndex: $selectedIndex)
                                }
                            }
                            .listStyle(.plain)
                            .scrollDismissesKeyboard(.interactively)
                            if mode == 0 {
                                Button {
                                    presentationMode.wrappedValue.dismiss()
                                } label: {
                                    BigButton(text: "生成我的旧时光")
                                }
                            } else if mode == 1 {
                                NavigationLink {
                                    PreviewView(selecedMusicIndex: selectedIndex)
                                } label: {
                                    BigButton(text: "生成我的旧时光")
                                }
                            }
                        }
                        if keyword != "" {
                            CandidateMusicList(selectedIndex: $selectedIndex, keyword: $keyword)
                        }
                    }
                }
                .padding(.top)
                .padding(.bottom, 50.0)
                .frame(height: UIScreen.main.bounds.height * 0.7)
                .background(.white)
                .cornerRadius(14)
            }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    recommendedIndex = -1
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
                Text(title)
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
    }
}

struct MusicView_Previews: PreviewProvider {
    static var previews: some View {
        MusicView(mode: 0, image: UIImage(named: "oil lamp")!, title: "我的回忆", selectedIndex: .constant(0))
    }
}

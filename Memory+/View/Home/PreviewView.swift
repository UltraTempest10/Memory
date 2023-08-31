//
//  PreviewView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/20.
//

import SwiftUI

struct PreviewView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selecedMusicIndex: Int?
    @State private var isPlaying = false
    @State var title = recommendedIndex == -1 ? Constants.object[keyObjectIndex] : Constants.recommended[recommendedIndex]
    @State var description = recommendedIndex == -1 ?  Constants.description[keyObjectIndex] : Constants.recommendedDesc[recommendedIndex]
    
    var body: some View {
        VStack {
            Rectangle()
                .frame(height: UIScreen.main.bounds.height * 0.126)
                .opacity(0)
            Image("frame")
            NavigationLink {
                ExperienceView(selecedMusicIndex: selecedMusicIndex, title: title)
            } label: {
                BigButton(text: "开始探索")
            }
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: UIScreen.main.bounds.height * 0.211)
                    .background(.white)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(
                            Font.custom("PingFang SC", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    Text(description)
                        .font(
                            Font.custom("PingFang SC", size: 14)
                                .weight(.medium)
                        )
                        .foregroundColor(Constants.gray)
                        .padding(.top, 10.0)
                }
                .padding(.all)
                .frame(height: UIScreen.main.bounds.height * 0.211)
            }
            Spacer()
        }
        .background(
//            .gray
            Image(uiImage: normalImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    recommendedIndex = -1
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
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
            if selecedMusicIndex != nil {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        if isPlaying {
                            isPlaying = false
                            pauseMusic()
                        } else {
                            isPlaying = true
                            playMusic(from: musicArray[selecedMusicIndex!].url)
                        }
                    } label: {
                        Image("music")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            }
        }
    }
}

struct PreviewView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewView(selecedMusicIndex: 0)
    }
}

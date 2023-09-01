//
//  ExperienceView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import SwiftUI

struct ExperienceView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var selecedMusicIndex: Int?
    @State private var isPlaying = false
    @State var title: String = ""
    @State private var showTip = true
    
    var body: some View {
        ZStack {
            PanoramaView()
                .ignoresSafeArea()
            if showTip {
                VStack {
                    Image("360tip")
                    Text("转动手机或划动屏幕开始体验")
                        .font(
                            Font.custom("PingFang SC", size: 22)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                }
                .padding(.top, 100.0)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationLink {
                    MainView()
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showTip = false
            }
        }
        .onDisappear {
            recommendedIndex = -1
            
            keyObjectIndex = 0
            normalImage = UIImage()
            panoramaImage = UIImage()
            
            if selecedMusicIndex != nil {
                musicArray[selecedMusicIndex!].isSelected = false
            }
        }
    }
}

struct ExperienceView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceView()
    }
}

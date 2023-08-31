//
//  MusicBar.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/29.
//

import SwiftUI

struct MusicBar: View {
    @State var index: Int
    @State private var isPlaying = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.height * 0.044)
                .background(Color(red: 0.31, green: 0.31, blue: 0.31))
                .cornerRadius(4)
            HStack {
                Image("music")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 35, height: 35)
                    .clipped()
                Spacer()
                if index >= 0 && index < musicArray.count {
                    Text(musicArray[index].title + "-" + musicArray[index].artist)
                        .font(
                            Font.custom("PingFang SC", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                        .frame(width: 116)
                    Spacer()
                    Button {
                        if isPlaying {
                            isPlaying = false
                            pauseMusic()
                        } else {
                            isPlaying = true
                            playMusic(from: musicArray[index].url)
                        }
                    } label: {
                        Image(isPlaying ? "pause" : "play")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)
                    }
                    .padding(.trailing, 1.0)
                    .buttonStyle(.borderless)
                }
            }
            .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width * 0.55, height: UIScreen.main.bounds.height * 0.044)
    }
}

struct MusicBar_Previews: PreviewProvider {
    static var previews: some View {
        MusicBar(index: 0)
    }
}

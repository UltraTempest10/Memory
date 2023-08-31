//
//  MusicPreviewRow.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/25.
//

import SwiftUI

struct MusicPreviewRow: View {
    var index: Int
    @State private var isPlaying = false
    
    var body: some View {
        HStack {
            if index >= 0 && index < musicArray.count {
                VStack(alignment: .leading) {
                    Text(musicArray[index].title)
                        .font(
                            Font.custom("PingFang SC", size: 18)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    Text(musicArray[index].artist)
                        .font(
                            Font.custom("PingFang SC", size: 14)
                                .weight(.medium)
                        )
                        .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35))
                }
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
                }
            }
        }
        .padding(.horizontal)
    }
}

struct MusicPreviewRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicPreviewRow(index: 0)
    }
}

//
//  MusicRow.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/24.
//

import SwiftUI

struct MusicRow: View {
    var index: Int
    @Binding var selectedIndex: Int?
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
                .buttonStyle(.borderless)
                .padding(.trailing)
                Button {
                    if selectedIndex == index {
                        musicArray[index].isSelected = false
                        selectedIndex = nil
                    } else {
                        if let selectedIndex = selectedIndex {
                            musicArray[selectedIndex].isSelected = false
                        }
                        musicArray[index].isSelected = true
                        selectedIndex = index
                    }
                } label: {
                    Image(selectedIndex == index ? "selected" : "circle")
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.horizontal)
        .onDisappear {
            if isPlaying {
                pauseMusic()
            }
        }
    }
}

struct MusicRow_Previews: PreviewProvider {
    static var previews: some View {
        MusicRow(index: 0, selectedIndex: .constant(0))
    }
}

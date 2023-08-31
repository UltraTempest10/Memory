//
//  CandidateMusicList.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/29.
//

import SwiftUI

struct CandidateMusicList: View {
    @Binding var selectedIndex: Int?
    @Binding var keyword: String
    var filteredMusicArray: [(Int, Music)] {
        musicArray.enumerated().filter { $0.element.title.contains(keyword) || $0.element.artist.contains(keyword) }
    }
    
    var body: some View {
        List {
            ForEach(filteredMusicArray, id: \.1.id) { (index, music) in
                Button {
                    if let selectedIndex = selectedIndex {
                        musicArray[selectedIndex].isSelected = false
                    }
                    musicArray[index].isSelected = true
                    selectedIndex = index
                    
                    keyword = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                } label: {
                    Text(musicArray[index].title + "-" + musicArray[index].artist)
                        .foregroundColor(.black)
                }
            }
        }
        .listStyle(.plain)
        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
        .opacity(!filteredMusicArray.isEmpty ? 1 : 0)
    }
}

struct CandidateList_Previews: PreviewProvider {
    static var previews: some View {
        CandidateMusicList(selectedIndex: .constant(0), keyword: .constant(""))
    }
}

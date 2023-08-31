//
//  PhotoBlock.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/29.
//

import SwiftUI

struct PhotoBlock: View {
    static let width = UIScreen.main.bounds.width * 0.432
    static let height = UIScreen.main.bounds.height * 0.331
    var index: Int
    var photo: UIImage = UIImage()
    var title: String = ""
    @State private var selectedMusicIndex: Int?
    @State private var showMusicView: Bool = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: PhotoBlock.width, height: PhotoBlock.height)
                .background(.white)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 4)
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: PhotoBlock.width * 0.9, height: PhotoBlock.height * 0.736)
                    .background(
                        Image(uiImage: photo)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: PhotoBlock.width * 0.9, height: PhotoBlock.height * 0.736)
                            .clipped()
                    )
                    .cornerRadius(6)
                Button {
                    normalImage = photo
                    recommendedIndex = index
                    showMusicView = true
                } label: {
                    SmallButton(text: "选择")
                }
                .padding(.top, 10.0)
                NavigationLink(destination: MusicView(mode: 1, image: photo, title: title, selectedIndex: $selectedMusicIndex), isActive: $showMusicView) {
                    EmptyView()
                }
            }
        }
    }
}

struct PhotoBlock_Previews: PreviewProvider {
    static var previews: some View {
        PhotoBlock(index: 0, photo: UIImage(named: "oil lamp") ?? UIImage())
    }
}

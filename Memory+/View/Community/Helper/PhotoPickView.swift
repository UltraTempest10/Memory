//
//  PhotoPickView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/31.
//

import SwiftUI
import Photos

struct PhotoPickView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var images: [UIImage]
    let columns = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible())]
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack {
            VStack {
                Image("Rectangle 2975")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.159)
                Spacer()
            }
            VStack {
//                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(0..<min(12, images.count), id: \.self) { index in
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.width * 0.32)
                                    .background(
                                        Image(uiImage: images[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: UIScreen.main.bounds.width * 0.32, height: UIScreen.main.bounds.width * 0.32)
                                            .clipped()
                                    )
                                PhotoButton(index: index, selectedButton: $selectedIndex)
                            }
                        }
                    }
//                }
                Spacer()
                if selectedIndex != -1 {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        BigButton(text: "完成")
                    }
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.067)
                            .background(Constants.lightGray)
                            .cornerRadius(28)
                            .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                        HStack {
                            Text("完成")
                                .font(
                                    Font.custom("PingFang SC", size: 24)
                                        .weight(.medium)
                                )
                                .foregroundColor(Constants.darkGray)
                        }
                    }
                }
            }
            .padding(.top, 1.0)
            .padding(.bottom, 16.0)
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.751)
            .clipShape(RoundedCorner(radius: 0, corners: [.topLeft, .topRight]))
        }
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("相册")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
    }
}

struct PhotoPickView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPickView(images: [], selectedIndex: .constant(0))
    }
}

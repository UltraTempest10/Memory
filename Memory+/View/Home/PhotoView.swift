//
//  PhotoView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/31.
//

import SwiftUI
import Photos

func fetchImages() -> [UIImage] {
    var images: [UIImage] = []
    let fetchOptions = PHFetchOptions()
    fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
    let fetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
    for i in 0..<fetchResult.count {
        let asset = fetchResult.object(at: i)
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { (image, info) in
            if let image = image {
                images.append(image)
            }
        }
    }
    return images
}

struct PhotoView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var images = fetchImages()
    let columns = [GridItem(.flexible(), spacing: 1), GridItem(.flexible(), spacing: 1), GridItem(.flexible())]
    @State private var selectedIndex: Int = -1
    
    var body: some View {
        VStack {
            ZStack {
                Image("Rectangle 2970")
                    .resizable()
                    .scaledToFill()
                HStack {
                    Text("从相册里选择自己的旧照")
                        .font(
                            Font.custom("PingFang SC", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.07)
                .padding(.top, UIScreen.main.bounds.height * 0.12)
            }
            .frame(height: UIScreen.main.bounds.height * 0.233)
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images.indices, id: \.self) { index in
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
            }
            Spacer()
            if selectedIndex != -1 {
                Button {
                    
                } label: {
                    BigButton(text: "生成场景")
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
                        Text("生成场景")
                            .font(
                                Font.custom("PingFang SC", size: 24)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.darkGray)
                    }
                }
            }
        }
        .padding(.bottom, 60.0)
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

struct PhotoView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView()
    }
}

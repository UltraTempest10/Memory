//
//  SelectView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import SwiftUI

struct SelectView: View {
    @Environment(\.presentationMode) var presentationMode
    var selectedIndices: [Int]
    @State private var selectedMusicIndex: Int?
    @State var image = normalImage
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    Image("Rectangle 2970")
                        .resizable()
                        .scaledToFill()
                        .frame(height: UIScreen.main.bounds.height * 0.233)
                    Spacer()
                }
                VStack {
                    Spacer()
                    HStack {
                        Text("根据你的关键词生成以下场景")
                            .font(
                                Font.custom("PingFang SC", size: 20)
                                    .weight(.medium)
                            )
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding([.leading, .bottom, .trailing])
                    HStack(spacing: 20) {
                        Text(Constants.era[selectedIndices[0]])
                            .font(
                                Font.custom("PingFang SC", size: 18)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 3.0)
                            .background(
                                Capsule()
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                            )
                        Text(Constants.city[selectedIndices[1]])
                            .font(
                                Font.custom("PingFang SC", size: 18)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 3.0)
                            .background(
                                Capsule()
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                            )
                        Text(Constants.object[selectedIndices[2]])
                            .font(
                                Font.custom("PingFang SC", size: 18)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 3.0)
                            .background(
                                Capsule()
                                    .fill(Color.white)
                                    .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                            )
                    }
                    .padding(.horizontal)
                }
            }
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.251)
            VStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: UIScreen.main.bounds.width * 0.797, height: UIScreen.main.bounds.height * 0.487)
                    .background(
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.797, height: UIScreen.main.bounds.height * 0.487)
                            .clipped()
                    )
                    .cornerRadius(10)
                    .shadow(color: .black.opacity(0.25), radius: 1.5, x: 0, y: 2)
                HStack {
                    Button {
                        
                    } label: {
                        SmallButton(text: "重新生成")
                            .frame(maxWidth: .infinity)
                    }
                    NavigationLink {
                        MusicView(mode: 1, image: image, title: Constants.object[selectedIndices[2]], selectedIndex: $selectedMusicIndex)
                    } label: {
                        SmallButton(text: "继续")
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding(.top, 50.0)
//                Spacer()
                Rectangle()
                    .frame(height: UIScreen.main.bounds.height * 0.1)
                    .opacity(0)
            }
            .padding(.horizontal)
            .padding(.top, 30.0)
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
                Text("关键词搜索")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            keyObjectIndex = selectedIndices[2]
            panoramaImage = UIImage(named: "360") ?? UIImage()
            normalImage = UIImage(named: "normal") ?? UIImage()
            
            image = normalImage
        }
    }
}

struct SelectView_Previews: PreviewProvider {
    static var previews: some View {
        SelectView(selectedIndices: [1, 2, 3])
    }
}

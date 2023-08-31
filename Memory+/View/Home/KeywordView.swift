//
//  KeywordView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/20.
//

import SwiftUI

struct KeywordView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode
    let columns = [GridItem(.flexible(), spacing: 20), GridItem(.flexible(), spacing: 20), GridItem(.flexible())]
    @State private var isKeyboardVisible = false
    @State var keyword: String = ""
    @State var era: Int = 0x7fffffff
    @State var city: Int = 0x7fffffff
    @State var object: Int = 0x7fffffff
    
    var body: some View {
        VStack {
            ZStack {
                Image("Rectangle 2970")
                    .resizable()
                    .scaledToFill()
                VStack {
                    Spacer()
                    SearchBar(placeholder: "例:80年代，黑白电视机", keyword: $keyword)
                        .padding(.bottom, 30.0)
                        .onReceive(keyboardPublisher) { newIsKeyboardVisible in
                            isKeyboardVisible = newIsKeyboardVisible
                        }
                }
            }
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.233)
            ZStack {
                VStack {
                    Text("年代")
                        .font(
                            Font.custom("PingFang SC", size: 24)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    LazyVGrid(columns: columns) {
                        ForEach(0..<Constants.era.count, id: \.self) { index in
                            KeywordButton(text: Constants.era[index], index: index, selectedButton: $era)
                        }
                    }
                    .padding(.bottom)
                    Text("地点")
                        .font(
                            Font.custom("PingFang SC", size: 24)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    LazyVGrid(columns: columns) {
                        ForEach(0..<Constants.city.count, id: \.self) { index in
                            KeywordButton(text: Constants.city[index], index: index, selectedButton: $city)
                        }
                    }
                    .padding(.bottom)
                    Text("物件")
                        .font(
                            Font.custom("PingFang SC", size: 24)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                    LazyVGrid(columns: columns) {
                        ForEach(0..<Constants.object.count, id: \.self) { index in
                            KeywordButton(text: Constants.object[index], index: index, selectedButton: $object)
                        }
                    }
                    .padding(.bottom, 50.0)
                    if era != 0x7fffffff && city != 0x7fffffff && object != 0x7fffffff {
                        NavigationLink {
                            SelectView(selectedIndices: [era, city, object])
                        } label: {
                            BigButton(text: "生成场景")
                        }
                    }
                    else {
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
//                    Spacer()
                    Rectangle()
                        .frame(height: UIScreen.main.bounds.height * 0.05)
                        .opacity(0)
                }
                
                .padding([.top, .leading, .trailing])
                if keyword != "" {
                    CandidateKeywordList(selectedEraIndex: $era, selectedCityIndex: $city, selectedObjectIndex: $object, keyword: $keyword)
                }
            }
            .background(Constants.bgColor)
        }
//        .frame(width: 375, height: 812)
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
                if !isKeyboardVisible {
                    Text("关键词搜索")
                        .font(Font
                            .custom("PingFang SC", size: 25)
                            .weight(.medium)
                        )
                        .foregroundColor(.white)
                }
            }
        }
    }
}

struct KeywordView_Previews: PreviewProvider {
    static var previews: some View {
        KeywordView()
    }
}

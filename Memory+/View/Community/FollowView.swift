//
//  FollowView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/9/1.
//

import SwiftUI

struct FollowView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var users = followList
    
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
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: UIScreen.main.bounds.height * 0.115)
                List {
                    ForEach(users.indices, id: \.self) { index in
                        NavigationLink {
                            ProfileView(user: users[index])
                        } label: {
                            HStack {
                                CircleImage(image: Image(uiImage: (users[index].avatar ?? UIImage(named: "default_avatar")) ?? UIImage()))
                                Text(users[index].nickname)
                                    .font(
                                        Font.custom("PingFang SC", size: 20)
                                            .weight(.medium)
                                    )
                                    .foregroundColor(.black)
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .listStyle(.plain)
                .background(Constants.bgColor)
                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
            }
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
                Text("关注列表")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                users = followList
            }
        }
    }
}

struct FollowView_Previews: PreviewProvider {
    static var previews: some View {
        FollowView()
    }
}

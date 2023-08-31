//
//  ProfileEditView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/31.
//

import SwiftUI
import Parse

struct ProfileEditView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var edited: Bool
    
    let images = fetchImages()
    @State private var showNewAvatar: Bool = false
    @State var info = profile
    @State var selectedImageIndex: Int = -1
    @State var nickname: String = profile.nickname
    @State var signature: String = profile.signature
    
    @State private var showNicknameAlert = false
    
    var body: some View {
        ZStack {
            VStack {
                Image("Rectangle 2975")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.159)
                Spacer()
            }
            VStack(spacing: 20) {
                NavigationLink {
                    PhotoPickView(images: images, selectedIndex: $selectedImageIndex)
                } label: {
                    HStack {
                        CircleImage(image: Image(uiImage: showNewAvatar ?  images[selectedImageIndex] : info.avatar!))
                        Text("修改头像")
                            .font(
                                Font.custom("PingFang SC", size: 18)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.gray)
                            .padding(.leading)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(Constants.lightGray)
                    }
                    .padding(.horizontal)
                }
                
                HStack {
                    Spacer()
                    Image("line")
                }
                .padding(.trailing)
                HStack {
                    HStack {
                        Text("*昵称")
                            .font(
                                Font.custom("PingFang SC", size: 20)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.gray)
                        Spacer()
                    }
                    .frame(width: 80)
                    TextField(info.nickname, text: $nickname)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.horizontal)
                HStack {
                    Spacer()
                    Image("line")
                }
                .padding(.trailing)
                HStack {
                    HStack {
                        Text("签名")
                            .font(
                                Font.custom("PingFang SC", size: 20)
                                    .weight(.medium)
                            )
                            .foregroundColor(Constants.gray)
                        Spacer()
                    }
                    .frame(width: 80)
                    TextField(info.signature, text: $signature)
                        .padding(.leading)
                    Spacer()

                }
                .padding(.horizontal)
                HStack {
                    Spacer()
                    Image("line")
                }
                .padding(.trailing)
                Spacer()
            }
            .padding(.top, 16.0)
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.751)
            .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
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
                Text("个人信息")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if nickname == "" {
                        showNicknameAlert = true
                    } else {
                        updateProfile()
                    }
                } label: {
                    Text("保存")
                        .font(
                            Font.custom("PingFang SC", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                }
                .alert(isPresented: $showNicknameAlert) {
                    Alert(title: Text("昵称不能为空"), message: Text("请输入昵称。"), dismissButton: .default(Text("OK")))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                info = Profile()
                info = profile
            }
        }
        .onChange(of: selectedImageIndex) { newValue in
            if selectedImageIndex >= 0 {
                showNewAvatar = true
            }
        }
    }
    
    func updateProfile() {
        print(profile.username)
        
        let query = PFQuery(className:"UserInfo")
        query.whereKey("username", equalTo: profile.username as Any)
        query.getFirstObjectInBackground { (user: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                user["nickname"] = nickname
                user["signature"] = signature
                if showNewAvatar {
                    let imageData = images[selectedImageIndex].pngData()
                    if imageData != nil {
                        let imageFile = PFFileObject(name:"\(profile.username).png", data:imageData!)
                        user["avatar"] = imageFile
                    }
                }
                user.saveInBackground {
                    (success: Bool, error: Error?) in
                    if (success) {
                        // The object has been saved.
                        print("Profile updated successfully.")
                        loadProfileData()
                        edited.toggle()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        // There was a problem, check error.description
                        print(error?.localizedDescription.description as Any)
                    }
                }
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(edited: .constant(false))
    }
}

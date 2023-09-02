//
//  FollowButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import SwiftUI
import Parse

struct FollowButton: View {
    @Binding var post: Post
    
    var body: some View {
        Button {
            post.isFollowed.toggle()
            update()
        } label: {
            Text(post.isFollowed ? "已关注" : "关注")
                .font(
                    Font.custom("PingFang SC", size: 14)
                        .weight(.medium)
                )
                .foregroundColor(post.isFollowed ? .white : .black)
                .padding(.horizontal, post.isFollowed ? 10 : 16)
                .padding(.vertical, 3.0)
                .background(
                    Capsule()
                        .fill(post.isFollowed ? Constants.accentColor : Color.clear)
                        .overlay(
                            Capsule()
                                .stroke(post.isFollowed ? Color.clear : Color.black, lineWidth: 2)
                        )
                )
        }
    }
    
    func update() {
        let userQuery = PFQuery(className:"UserInfo")
        userQuery.whereKey("username", equalTo: profile.username as Any)
        userQuery.getFirstObjectInBackground { (user: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                if post.isFollowed {
                    user.addUniqueObjects(from: [post.creatorUsername], forKey: "follow_list")
                } else {
                    user.removeObjects(in: [post.creatorUsername], forKey: "follow_list")
                }
                user.saveInBackground()
            }
        }
        
        loadProfileData(favorite: false, like:  false, follow:  true)
    }
}

struct FollowButton_Previews: PreviewProvider {
    static var previews: some View {
        FollowButton(post: .constant(Post()))
    }
}

//
//  LikeButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/28.
//

import SwiftUI
import Parse

struct LikeButton: View {
    @Binding var post: Post
    
    var body: some View {
        Button {
            post.isLiked.toggle()
            if post.isLiked {
                post.like += 1
            }
            else {
                post.like -= 1
            }
            update()
        } label: {
            Label("Toggle Like"/*for VoiceOver*/, systemImage: post.isLiked ? "heart.fill" : "heart")
                .labelStyle(.iconOnly)
                .foregroundColor(post.isLiked ? .red : .gray)
        }
    }
    
    func update() {
        let query = PFQuery(className:"Post")
        query.getObjectInBackground(withId: post.id) { (targetPost: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let targetPost = targetPost {
                targetPost["like"] = post.like
                targetPost.saveInBackground()
            }
        }
        
        let userQuery = PFQuery(className:"UserInfo")
        userQuery.whereKey("username", equalTo: profile.username as Any)
        userQuery.getFirstObjectInBackground { (user: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                if post.isLiked {
                    user.addUniqueObjects(from: [post.id], forKey: "like_list")
                } else {
                    user.removeObjects(in: [post.id], forKey: "like_list")
                }
                user.saveInBackground()
            }
        }
        
        loadProfileData()
    }
}

struct LikeButton_Previews: PreviewProvider {
    static var previews: some View {
        LikeButton(post: .constant(Post()))
    }
}

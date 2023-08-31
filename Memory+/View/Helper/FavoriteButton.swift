//
//  FavoriteButton.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/28.
//

import SwiftUI
import Parse

struct FavoriteButton: View {
    @Binding var post: Post
    
    var body: some View {
        Button {
            post.isFavorite.toggle()
            if post.isFavorite {
                post.favorite += 1
            }
            else {
                post.favorite -= 1
            }
            update()
        } label: {
            Label("Toggle Favorite"/*for VoiceOver*/, systemImage: post.isFavorite ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(post.isFavorite ? .yellow : .gray)
        }
    }
    
    func update() {
        let query = PFQuery(className:"Post")
        query.getObjectInBackground(withId: post.id) { (targetPost: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let targetPost = targetPost {
                targetPost["favorite"] = post.favorite
                targetPost.saveInBackground()
            }
        }
        
        let userQuery = PFQuery(className:"UserInfo")
        userQuery.whereKey("username", equalTo: profile.username as Any)
        userQuery.getFirstObjectInBackground { (user: PFObject?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user {
                if post.isFavorite {
                    user.addUniqueObjects(from: [post.id], forKey: "favorite_list")
                } else {
                    user.removeObjects(in: [post.id], forKey: "favorite_list")
                }
                user.saveInBackground()
            }
        }
        
        loadProfileData()
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(post: .constant(Post()))
    }
}

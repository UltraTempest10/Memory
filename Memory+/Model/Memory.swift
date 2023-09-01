//
//  Memory.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/30.
//

import Foundation
import Parse

class Memory {
    var posts: [Post] = []
}

var memories = Memory()

func loadMemoryData() {
    let query = PFQuery(className:"Post")
    query.cachePolicy = .networkElseCache
    query.whereKey("creator", equalTo: profile.username)
    query.order(byDescending: "createdAt")
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let objects = objects {
            for (index, object) in objects.enumerated() {
                var post = Post()
                if !memories.posts.contains(where: { $0.id == object.objectId }) {
                    if memories.posts.count < objects.count {
                        memories.posts.append(post)
                    }
                    
                    memories.posts[index].id = object.objectId ?? ""
                    memories.posts[index].creator = profile.nickname
                    memories.posts[index].creatorUsername = profile.username
                    memories.posts[index].timestamp = object.createdAt ?? Date()
                    
                    memories.posts[index].title = object["title"] as? String ?? ""
                    memories.posts[index].content = object["content"] as? String ?? ""
                    
                    memories.posts[index].avatar = profile.avatar!
                    
                    memories.posts[index].musicId = object["music_id"] as? String ?? ""
                    
                    memories.posts[index].voiceTexts = object["voice_text"] as! [String]
                    if let audioFiles = object["voice_file"] as? [PFFileObject] {
                        for audioFile in audioFiles {
                            let url = audioFile.url!
                            memories.posts[index].voiceURLs.append(url)
                        }
                    }
                    
                    if profile.favoriteList.contains(memories.posts[index].id) {
                        memories.posts[index].isFavorite = true
                    }
                    if profile.likeList.contains(memories.posts[index].id) {
                        memories.posts[index].isLiked = true
                    }
                    
                    if let image = object["picture"] as? PFFileObject {
                        image.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else if let imageData = imageData {
                                memories.posts[index].picture = UIImage(data: imageData)!
                            }
                        }
                    } else {
                        memories.posts[index].picture = UIImage()
                    }
                }
            }
        }
    }
}

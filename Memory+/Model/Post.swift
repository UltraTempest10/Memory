//
//  Post.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/28.
//

import Foundation
import SwiftUI
import Parse

struct Post: Identifiable {
    var id: String = ""
    var creator: String = ""
    var creatorUsername: String = ""
    var timestamp: Date = Date()
    var sincePost: String {
        toNow(date: timestamp)
    }
    var title: String = ""
    var content: String = ""
    
    var avatar: UIImage = UIImage(named: "default_avatar")!
    var picture: UIImage = UIImage()
    
    var musicId: String = ""
    
    var voiceTexts: [String] = []
    var voiceURLs: [String] = []
    
    var favorite: Int = 0
    var like: Int = 0
    var isFavorite: Bool = false
    var isLiked: Bool = false
    var isFollowed: Bool = false
    
    private func toNow(date: Date) -> String {
        let now = Date()
        let pastDate = date
        
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: pastDate, to: now)
        
        if let years = components.year, years > 0 {
            return "\(years) 年前"
        }
        else if let months = components.month, months > 0 {
            return "\(months) 个月前"
        }
        else if let days = components.day, days > 0 {
            return "\(days) 天前"
        }
        else if let hours = components.hour, hours > 0 {
            return "\(hours) 小时前"
        }
        else if let minutes = components.minute, minutes > 0 {
            return "\(minutes) 分钟前"
        }
        else {
            return "刚刚"
        }
    }
}

var postArray: [Post] = []

func loadPostData() {
    var awaiting = false
    postArray.removeAll()
    let query = PFQuery(className:"Post")
    query.limit = 10
    query.whereKey("creator", notEqualTo: profile.username)
    query.order(byDescending: "like")
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let objects = objects {
            for object in objects {
                var post = Post()
                post.id = object.objectId ?? ""
                post.creatorUsername = object["creator"] as? String ?? ""
                
                let userQuery = PFQuery(className: "UserInfo")
                userQuery.whereKey("username", equalTo: object["creator"]!)
                userQuery.getFirstObjectInBackground { (object, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let object = object {
                        post.creator = object["nickname"] as? String ?? "Memory+用户"
                        let userImageFile = object["avatar"] as! PFFileObject
                        userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else if let imageData = imageData {
                                post.avatar = UIImage(data:imageData)!
                                if awaiting && !postArray.contains(where: { $0.id == post.id }) {
                                    postArray.append(post)
                                }
                            }
                        }
                    }
                }
 
                post.timestamp = object.createdAt ?? Date()
                
                post.title = object["title"] as? String ?? ""
                post.content = object["content"] as? String ?? ""
                
                post.favorite = object["favorite"] as! Int
                post.like = object["like"] as! Int
                if profile.favoriteList.contains(post.id) {
                    post.isFavorite = true
                }
                if profile.likeList.contains(post.id) {
                    post.isLiked = true
                }
                if profile.followList.contains(post.creatorUsername) {
                    post.isFollowed = true
                }
                        
                post.musicId = object["music_id"] as? String ?? ""
                
                post.voiceTexts = object["voice_text"] as! [String]
                if let audioFiles = object["voice_file"] as? [PFFileObject] {
                    for audioFile in audioFiles {
                        let url = audioFile.url!
                        post.voiceURLs.append(url)
                    }
                }
                
                if let image = object["picture"] as? PFFileObject {
                    image.getDataInBackground { (imageData: Data?, error: Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let imageData = imageData {
                            post.picture = UIImage(data: imageData)!
                            if post.creator != "" {
                                if !postArray.contains(where: { $0.id == post.id }) {
                                    postArray.append(post)
                                }
                            } else {
                                awaiting = true
                            }
                        }
                    }
                } else {
                    if post.creator != "" {
                        if !postArray.contains(where: { $0.id == post.id }) {
                            postArray.append(post)
                        }
                    } else {
                        awaiting = true
                    }
                }
            }
        }
    }
}

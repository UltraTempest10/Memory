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
    var signature: String = "属于我的独特记忆……"
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
    query.limit = 6
    query.whereKey("creator", notEqualTo: profile.username)
    query.whereKey("creator", containedIn: profile.followList)
//    query.order(byDescending: "like")
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
                        post.signature = object["signature"] as? String ?? "属于我的独特记忆……"
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
            if objects.count < 12 {
                let additionalQuery = PFQuery(className: "Post")
                additionalQuery.whereKey("creator", notEqualTo: profile.username)
                additionalQuery.whereKey("creator", notContainedIn: profile.followList)
                additionalQuery.order(byDescending: "like")
                additionalQuery.limit = 12 - objects.count
                additionalQuery.findObjectsInBackground { (additionalObjects, error) in
                    if let error = error {
                        // Handle error
                        print(error.localizedDescription)
                    } else if let additionalObjects = additionalObjects {
                        // additionalObjects contains the randomly returned posts
                        for object in additionalObjects {
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
        }
    }
}

var favoriteArray: [Post] = []

func loadFavoriteData() {
    favoriteArray.removeAll()
    var awaiting = false
    let query = PFQuery(className:"Post")
    query.whereKey("objectId", containedIn: profile.favoriteList)
//    query.order(byDescending: "like")
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
                                if awaiting && !favoriteArray.contains(where: { $0.id == post.id }) {
                                    favoriteArray.append(post)
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
                                if !favoriteArray.contains(where: { $0.id == post.id }) {
                                    favoriteArray.append(post)
                                }
                            } else {
                                awaiting = true
                            }
                        }
                    }
                } else {
                    if post.creator != "" {
                        if !favoriteArray.contains(where: { $0.id == post.id }) {
                            favoriteArray.append(post)
                        }
                    } else {
                        awaiting = true
                    }
                }
            }
        }
    }
}

var likeArray: [Post] = []

func loadLikeData() {
    likeArray.removeAll()
    var awaiting = false
    let query = PFQuery(className:"Post")
    query.whereKey("objectId", containedIn: profile.likeList)
//    query.order(byDescending: "like")
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
                                if awaiting && !likeArray.contains(where: { $0.id == post.id }) {
                                    likeArray.append(post)
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
                                if !likeArray.contains(where: { $0.id == post.id }) {
                                    likeArray.append(post)
                                }
                            } else {
                                awaiting = true
                            }
                        }
                    }
                } else {
                    if post.creator != "" {
                        if !likeArray.contains(where: { $0.id == post.id }) {
                            likeArray.append(post)
                        }
                    } else {
                        awaiting = true
                    }
                }
            }
        }
    }
}

var userPosts: [Post] = []

func loadUserPostData(user: Profile) {
    userPosts.removeAll()
    let query = PFQuery(className:"Post")
    query.whereKey("creator", equalTo: user.username)
    query.order(byDescending: "createdAt")
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let objects = objects {
            for (index, object) in objects.enumerated() {
                var post = Post()
                if !userPosts.contains(where: { $0.id == object.objectId }) {
                    if userPosts.count < objects.count {
                        userPosts.append(post)
                    }
                    userPosts[index].id = object.objectId ?? ""
                    userPosts[index].creatorUsername = user.username
                    
                    userPosts[index].creator = user.nickname
                    userPosts[index].avatar = user.avatar ?? UIImage(named: "default_avatar") ?? UIImage()
                
                    userPosts[index].timestamp = object.createdAt ?? Date()
                    
                    userPosts[index].title = object["title"] as? String ?? ""
                    userPosts[index].content = object["content"] as? String ?? ""
                    
                    userPosts[index].favorite = object["favorite"] as! Int
                    userPosts[index].like = object["like"] as! Int
                    if profile.favoriteList.contains(userPosts[index].id) {
                        userPosts[index].isFavorite = true
                    }
                    if profile.likeList.contains(userPosts[index].id) {
                        userPosts[index].isLiked = true
                    }
                    if profile.followList.contains(user.username) {
                        userPosts[index].isFollowed = true
                    }
                    
                    userPosts[index].musicId = object["music_id"] as? String ?? ""
                    
                    userPosts[index].voiceTexts = object["voice_text"] as! [String]
                    if let audioFiles = object["voice_file"] as? [PFFileObject] {
                        for audioFile in audioFiles {
                            let url = audioFile.url!
                            userPosts[index].voiceURLs.append(url)
                        }
                    }
                    
                    if let image = object["picture"] as? PFFileObject {
                        image.getDataInBackground { (imageData: Data?, error: Error?) in
                            if let error = error {
                                print(error.localizedDescription)
                            } else if let imageData = imageData {
                                userPosts[index].picture = UIImage(data: imageData)!
                            }
                        }
                    } else {
                        userPosts[index].picture = UIImage()
                    }
                }
            }
        }
    }
}

//
//  Profile.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/20.
//

import Foundation
import Parse

class Profile {
    var currentUser = PFUser.current()
    var username = ""
    var nickname = "Memory+用户"
    var avatar = UIImage(named: "default_avatar")
    var signature = "属于我的独特记忆……"
    var favoriteCount = 0
    var favoriteList: [String] = []
    var likeCount = 0
    var likeList: [String] = []
    var followCount = 0
    var followList: [String] = []
    
    init(username: String, nickname: String, avatar: UIImage, signature: String) {
        self.username = username
        self.nickname = nickname
        self.avatar = avatar
        self.signature = signature
    }
    
    init() {
        
    }
}

var profile = Profile()

func loadProfileData() {
    let query = PFQuery(className:"UserInfo")
    query.cachePolicy = .networkElseCache
    query.whereKey("username", equalTo: PFUser.current()?.username as Any)
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let objects = objects {
            // The find succeeded.
            print("Successfully retrieved user info.")
            // Do something with the found objects
            for object in objects {
                profile.username = object["username"] as! String
                profile.nickname = object["nickname"] as! String
                profile.signature = object["signature"] as! String
                
                if let userImageFile = object["avatar"] as? PFFileObject {
                    userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let imageData = imageData {
                            profile.avatar = UIImage(data:imageData)!
                        }
                    }
                }
                if let favoriteList = object["favorite_list"] as? [String] {
                    profile.favoriteList = favoriteList
                } else {
                    profile.favoriteList = []
                }
                profile.favoriteCount = profile.favoriteList.count
                if let likeList = object["like_list"] as? [String] {
                    profile.likeList = likeList
                } else {
                    profile.likeList = []
                }
                profile.likeCount = profile.likeList.count
                if let followList = object["follow_list"] as? [String] {
                    profile.followList = followList
                } else {
                    profile.followList = []
                }
                profile.followCount = profile.followList.count
            }
        }
        loadMemoryData()
        loadPostData()
        loadFollowData()
        loadFavoriteData()
        loadLikeData()
    }
}

var followList: [Profile] = []

func loadFollowData() {
    followList.removeAll()
    let query = PFQuery(className:"UserInfo")
    query.cachePolicy = .networkElseCache
    query.whereKey("username", containedIn: profile.followList)
    query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let objects = objects {
            // The find succeeded.
            print("Successfully retrieved user info.")
            // Do something with the found objects
            for object in objects {
                var info = Profile()
                info.username = object["username"] as! String
                info.nickname = object["nickname"] as! String
                info.signature = object["signature"] as! String
                
                if let userImageFile = object["avatar"] as? PFFileObject {
                    userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let imageData = imageData {
                            info.avatar = UIImage(data:imageData)!
                            if !followList.contains(where: { $0.username == info.username }) {
                                followList.append(info)
                            }
                        }
                    }
                }
            }
        }
    }
}

var user = Profile()

func loadUserData(username: String) {
    user = Profile()
    let query = PFQuery(className:"UserInfo")
    query.whereKey("username", containedIn: profile.followList)
    query.getFirstObjectInBackground { (object, error) in
        if let error = error {
            // Log details of the failure
            print(error.localizedDescription)
        } else if let object = object {
            user.username = username
            user.nickname = object["nickname"] as! String
            user.signature = object["signature"] as! String
            
            if let userImageFile = object["avatar"] as? PFFileObject {
                userImageFile.getDataInBackground { (imageData: Data?, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let imageData = imageData {
                        user.avatar = UIImage(data:imageData)!
                    }
                }
            }
        }
    }
}

//
//  Music.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/24.
//

import AVFoundation
import Parse

struct Music: Identifiable {
    var id: String
    var title: String
    var artist: String
    var url: String
    var isSelected: Bool = false
}

var musicArray: [Music] = []
var player: AVPlayer?

func loadMusicData() {
    let query = PFQuery(className: "Music")
    query.cachePolicy = .networkElseCache
    query.findObjectsInBackground { (objects, error) in
        if let error = error {
            print(error.localizedDescription)
        } else if let objects = objects {
            for object in objects {
                let id = object.objectId ?? ""
                let title = object["title"] as? String ?? ""
                let artist = object["artist"] as? String ?? ""
                let file = object["data"] as? PFFileObject
                let url = file?.url ?? ""
                let music = Music(id: id, title: title, artist: artist, url: url)
                musicArray.append(music)
            }
        }
    }
}

func playMusic(from urlString: String) {
    if let url = URL(string: urlString) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }
}

func pauseMusic() {
    player?.pause()
}

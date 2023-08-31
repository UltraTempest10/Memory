//
//  Panorama.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import Foundation
import SwiftUI

var recommendedIndex: Int = -1

var keyObjectIndex: Int = 0
var normalImage: UIImage = UIImage()
var panoramaImage: UIImage = UIImage()

func imageFromURL(urlString: String) -> UIImage? {
    guard let url = URL(string: urlString) else { return nil }
    guard let data = try? Data(contentsOf: url) else { return nil }
    return UIImage(data: data)
}

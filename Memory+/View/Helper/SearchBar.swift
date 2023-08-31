//
//  SearchBar.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/29.
//

import SwiftUI

struct SearchBar: View {
    var placeholder: String = ""
    @Binding var keyword: String
    
    var body: some View {
        ZStack {
            TextField("🔍 " + placeholder, text: $keyword)
                .padding(.leading, 10)
                .frame(width: UIScreen.main.bounds.width * 0.888, height: 41)
                .background(Color(red: 0.98, green: 0.98, blue: 0.98))
                .cornerRadius(20.5)
                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
        }
    }
}

struct MusicSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(keyword: .constant(""))
    }
}

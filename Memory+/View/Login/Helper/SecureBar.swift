//
//  SecureBar.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/26.
//

import SwiftUI

struct SecureBar: View {
    var placeholder: String = ""
    @Binding var text: String
    
    var body: some View {
        ZStack {
            SecureField(placeholder, text: $text)
                .padding(.leading, 10)
                .frame(width: UIScreen.main.bounds.width * 0.752, height: UIScreen.main.bounds.height * 0.058)
                .background(Color(red: 0.97, green: 0.97, blue: 0.97))
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
        }
    }
}

struct SecureBar_Previews: PreviewProvider {
    static var previews: some View {
        SecureBar(text: .constant(""))
    }
}

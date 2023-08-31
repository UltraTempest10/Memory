//
//  VoiceRow.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/28.
//

import SwiftUI

struct VoiceRow: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(
                Font.custom("PingFang SC", size: 18)
                    .weight(.medium)
            )
            .foregroundColor(.black)
            .padding(.horizontal)
            .background() {
                Rectangle()
                    .foregroundColor(Color(red: 0.9, green: 0.89, blue: 0.84))
                    .cornerRadius(7)
            }
            .multilineTextAlignment(.leading)
    }
}

struct VoiceRow_Previews: PreviewProvider {
    static var previews: some View {
        VoiceRow(text: "雷麻街道有着传统和淳朴的民风")
    }
}

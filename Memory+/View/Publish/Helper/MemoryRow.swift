//
//  MemoryRow.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/20.
//

import SwiftUI

struct MemoryRow: View {
    var memory: Post
    let calendar = Calendar.current
    let weekdays = ["", "星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"]
    
    var body: some View {
        HStack {
            VStack {
                HStack(spacing: 2) {
                    Text("\(calendar.component(.day, from: memory.timestamp))")
                        .font(
                            Font.custom("PingFang SC", size: 22)
                                .weight(.medium)
                        )
                        .foregroundColor(Constants.accentColor)
                        .frame(width: 27, alignment: .topLeading)
                    Text(weekdays[calendar.component(.weekday, from: memory.timestamp)])
                        .font(
                            Font.custom("PingFang SC", size: 10)
                                .weight(.medium)
                        )
                        .foregroundColor(.black)
                }
                Text(verbatim: "\(calendar.component(.year, from: memory.timestamp)).\(calendar.component(.month, from: memory.timestamp))")
                .font(Font.custom("PingFang SC", size: 14))
                .foregroundColor(Constants.gray)
            }
            Image("separator")
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(.white)
                    .cornerRadius(6)
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                HStack {
                    VStack(alignment: .leading) {
                        Text(memory.title)
                            .font(
                                Font.custom("PingFang SC", size: 18)
                                    .weight(.medium)
                            )
                            .foregroundColor(.black)
                        let hour = calendar.component(.hour, from: memory.timestamp)
                        let minute = calendar.component(.minute, from: memory.timestamp)
                        let formattedTime = String(format: "%02d:%02d", hour, minute)
                        Text(formattedTime)
                            .font(Font.custom("PingFang SC", size: 14))
                            .foregroundColor(Color(red: 0.35, green: 0.35, blue: 0.35))
                    }
                    Spacer()
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 78, height: 78)
                        .background(
                            Image(uiImage: memory.picture)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 78, height: 78)
                                .clipped()
                        )
                        .cornerRadius(4)
                }
                .padding(.horizontal, 6.0)
            }
            .frame(width: UIScreen.main.bounds.width * 0.685, height: 88)
        }
    }
}

struct MemoryRow_Previews: PreviewProvider {
    static var previews: some View {
        MemoryRow(memory: Post())
    }
}

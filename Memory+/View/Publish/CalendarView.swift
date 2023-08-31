//
//  CalendarView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/30.
//

import SwiftUI

struct CalendarView: View {
    @Environment(\.presentationMode) var presentationMode
    var loginState: Int
    @State var date = Date()
    let startDate = profile.currentUser?.createdAt ?? Date()
    let endDate = Date()
    var filteredMemoryArray: [Post] {
        memories.posts.filter { Calendar.current.isDate($0.timestamp, inSameDayAs: date) }
    }
    
    var body: some View {
        ZStack {
            VStack {
                Image("Rectangle 2975")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.09)
                Spacer()
            }
            VStack {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(height: UIScreen.main.bounds.height * 0.425)
                        .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 4)
                    DatePicker(
                        "Start Date",
                        selection: $date,
                        in: startDate...endDate,
                        displayedComponents: [.date]
                    )
                    .datePickerStyle(.graphical)
                }
                if !filteredMemoryArray.isEmpty {
                    ScrollView {
                        ForEach(filteredMemoryArray.indices, id: \.self) { index in
                            NavigationLink {
                                PostDetail(loginState: loginState, post: filteredMemoryArray[index])
                            } label: {
                                MemoryRow(memory: filteredMemoryArray[index])
                            }
                        }
                    }
                    .padding(.top)
                    .background(Constants.bgColor)
                }
                Spacer()
            }
            .padding(.top, UIScreen.main.bounds.height * 0.169)
            .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
        }
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
            }
            ToolbarItem(placement: .principal) {
                Text("日历")
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .foregroundColor(.white)
            }
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(loginState: 0)
    }
}

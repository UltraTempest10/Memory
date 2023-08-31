//
//  MainView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/6/19.
//

import SwiftUI

struct MainView: View {
    @State private var selected: Int = Constants.home
    @State var isLoggedIn = UserDefaults.standard.integer(forKey: "isLoggedIn")
    
    var body: some View {
        NavigationStack {
            if isLoggedIn == 0 {
                StartView(loginState: $isLoggedIn)
            }
            else {
                ZStack {
                    switch selected {
                    case Constants.home:
                        HomeView()
                    case Constants.publish:
                        PublishView(loginState: isLoggedIn)
                    case Constants.community:
                        CommunityView(loginState: $isLoggedIn)
                    default:
                        Text("")
                    }
                    TabBar(selected: $selected)
                    //                    .padding(.bottom, 50.0)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            isLoggedIn = UserDefaults.standard.integer(forKey: "isLoggedIn")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(ModelData())
    }
}

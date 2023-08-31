//
//  TabBar.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/19.
//

import SwiftUI

struct TabBar: View {
    @Binding var selected: Int
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: 375, height: 20)
                    .opacity(0)
                Image("Rectangle 2965")
    //                .frame(width: 375, height: 83)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            HStack {
                Button {
                    selected = Constants.home
                } label: {
                    ZStack {
                        if selected == Constants.home {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Constants.accentColor)
                            Image("home_selected")
                                .frame(width: 28, height: 28)
                        }
                        else {
                            Image("home")
                                .frame(width: 28, height: 28)
                        }
                    }
                    .frame(maxWidth: .infinity) // uniform distribution
                }
                Button {
                    selected = Constants.publish
                } label: {
                    VStack {
                        ZStack {
                            if selected == Constants.publish {
                                Image("M_selected")
                                    .frame(width: 40, height: 40)
                            }
                            else {
                                Image("M")
                                    .frame(width: 40, height: 40)
                            }
                        }
                        Spacer()
                    }
                }
                Button {
                    selected = Constants.community
                } label: {
                    ZStack {
                        if selected == Constants.community {
                            Circle()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Constants.accentColor)
                            Image("community_selected")
                                .frame(width: 28, height: 28)
                        }
                        else {
                            Image("community")
                                .frame(width: 28, height: 28)
                        }
                    }
                    .frame(maxWidth: .infinity) // uniform distribution
                }
            }
        }
        .frame(width: 375, height: 100)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .ignoresSafeArea()
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(selected: Binding.constant(Constants.home))
    }
}

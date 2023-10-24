//
//  MainView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct MainView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var body: some View {
        TabView {
            NavigationView {
                LikeView()
            }
            .tabItem {
                Label("main_view_game".localized,
                      systemImage: "flame.circle")
                    .font(.title)
            }

            NavigationView {
                AllChatsView()
            }
            .tabItem {
                Label("main_view_chat".localized,
                      systemImage: "ellipsis.message")
                    .font(.title)
            }

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("main_view_profile".localized,
                      systemImage: "person.circle")
                    .font(.title)
            }
        }
        .background(Color(.systemGray6))
        .accentColor(.purple)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

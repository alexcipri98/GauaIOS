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
                PubsListView()
            }
            .tabItem {
                Image("PubsGlobe")
            }
            
            NavigationView {
                LikeView()
            }
            .tabItem {
                Image("Tickets")
            }

            NavigationView {
                AllChatsView()
            }
            .tabItem {
                Image("Matches")
            }

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Image("User")
            }
        }
        .background(Color(.systemGray6))
        .accentColor(.yellow)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

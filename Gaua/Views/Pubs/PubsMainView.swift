//
//  PubsMainView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import SwiftUI

struct PubsMainView: View {
    var body: some View {
        TabView {
            NavigationView {
                PubsListView()
            }
            .tabItem {
                Image("Tickets")
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

struct PubsMainView_Previews: PreviewProvider {
    static var previews: some View {
        PubsMainView()
    }
}

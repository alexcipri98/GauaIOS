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
                //ChatView()
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
        .accentColor(.purple)
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


extension View {
    @ViewBuilder
    func `if`<Content: View>(_ condition: Bool, content: (Self) -> Content) -> some View {
        if condition {
            content(self)
        } else {
            self
        }
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

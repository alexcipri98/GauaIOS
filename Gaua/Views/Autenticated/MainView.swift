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
                Label("Game", systemImage: "flame.circle")
                    .font(.title)
            }

            NavigationView {
                ChatView()
            }
            .tabItem {
                Label("Chat", systemImage: "ellipsis.message")
                    .font(.title)
            }

            NavigationView {
                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person.circle")
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

//
//  ContentView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//

import SwiftUI

struct ParentView: View {
    @EnvironmentObject private var router: Router
    
    var body: some View {
        NavigationView {
            VStack {
                switch router.currentDestination {
                case .login:
                  //  LoginView()
                    RegisterView()
                case .main:
                    MainView()
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}

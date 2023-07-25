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
            VStack { // Agregamos un contenedor vertical
                switch router.currentDestination {
                case .login:
                    LoginView()
                case .main:
                    MainView()
                }
            }
            /*.navigationTitle("App Title")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(false)*/
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}


struct ParentView_Previews: PreviewProvider {
    static var previews: some View {
        ParentView()
    }
}

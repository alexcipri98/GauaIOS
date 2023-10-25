//
//  ContentView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//

import SwiftUI
import FirebaseAuth

struct ParentView: View {
    @EnvironmentObject private var router: RouterViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                
                    if router.isAuthenticated || router.currentDestination == .main{
                        MainView() // La vista principal cuando el usuario está autenticado.
                    } else {
                        NavigationStack  {
                            PhoneNumberRequestView()
                        }
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

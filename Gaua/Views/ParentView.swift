//
//  ContentView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//
import SwiftUI

struct ParentView: View {
    @EnvironmentObject private var router: RouterViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if router.isAuthenticatedUserClient || router.currentDestination == .main {
                        MainView() // La vista principal cuando el usuario está autenticado.
                    } else if router.isAuthenticatedPubClient || router.currentDestination == .mainPubs {
                        PubsMainView()
                    } else {
                        NavigationStack  {
                            PhoneNumberRequestView()
                        }
                    }
                }
                .alert(isPresented: $router.showAlert) {
                    Alert(title: Text("any_view_error".localized),
                          message: Text(router.alertMessage),
                          dismissButton: .default(Text("any_view_accept".localized)))
                }
                if router.isLoading {
                    LoadingView()
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

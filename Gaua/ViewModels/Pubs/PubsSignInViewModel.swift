//
//  PubsSignInViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import Foundation

final class PubsSignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    private let authService: AuthService = AuthService()
    private let pubsSignInService: PubsSignInService = PubsSignInService()
    
    func login() {
        NavigationServiceViewModel.shared.showLoading()
        authService.signInEmail(email: email,
                                password: password,
                                onSuccess: {
            self.pubsSignInService.getUser(email: self.email,
                                           onSuccess: { pubsPerson in
                NavigationServiceViewModel.shared.pubsUserSession = pubsPerson
                NavigationServiceViewModel.shared.navigateTo(destination: .mainPubs)
                NavigationServiceViewModel.shared.hideLoading()
            },
                                           onFailure: { error in
                NavigationServiceViewModel.shared.hideLoading()
                NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
            })
        },
                                onFailure: {error in
            NavigationServiceViewModel.shared.hideLoading()
            NavigationServiceViewModel.shared.showError(text: error?.localizedDescription)
        })
    }
}

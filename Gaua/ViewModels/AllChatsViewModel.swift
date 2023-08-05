//
//  AllChatsViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/7/23.
//

import Foundation

class AllChatsViewModel: ObservableObject {
    @Published var matches : [Match] = []
    @Published var isLoading : Bool = true
    private var allChatsService = AllChatsService()
    
    init() {
        getMatches()
    }
    
    func getMatches() {
        allChatsService.getMatches(onSuccess: { newMatches in
            self.matches = newMatches
            self.isLoading = false
        }, onFailure: { error in
            print(error?.localizedDescription ?? "")
            self.isLoading = false
        })
    }
    
}

//
//  LikeView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct LikeView: View {
    @StateObject private var viewModel = LikeViewModel()
    var body: some View {
        if viewModel.isNotLikedIn {
            /*LoadingView().onAppear{
                if viewModel.people.isEmpty {
                    viewModel.readUsers()
                }
            }*/
        } else {
            VStack {
                ZStack {
                    ForEach(viewModel.people) { user in
                        CardView(users: $viewModel.people,
                                 user: user,
                                 methodToRemoveLastUser: self.discardUser,
                                 methodToLikeUser: self.likeUser)
                        .gesture(
                            DragGesture()
                                .onEnded { gesture in
                                    if gesture.translation.width < -100 {
                                        discardUser(user)
                                    }
                                }
                        )
                        .onAppear {
                            if isLastUser(user: user) && !viewModel.isFetching {
                                viewModel.fetchMoreUsers()
                            }
                        }
                    }
                }
                .padding()
                Spacer()
            }
        }
    }
    func isLastUser(user: Person) -> Bool {
        guard let lastUser = viewModel.people.last else {
            return false
        }
        return lastUser.id == user.id
    }
    private func discardUser(_ user: Person) {
        viewModel.discardUser(user: user)
    }
    
    private func likeUser(_ user: Person) {
        viewModel.likeUser(user: user)
    }
}

struct LikeView_Previews: PreviewProvider {
    static var previews: some View {
        LikeView()
    }
}

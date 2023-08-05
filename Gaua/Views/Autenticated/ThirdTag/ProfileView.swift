//
//  ProfileView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        ScrollView() {
            ImageUserProfileView().environmentObject(viewModel)
            
            VStack(alignment: .leading, spacing: 10) {
                BodyOfProfileView()
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.height * 0.8)
        .padding(.trailing)
        .padding(.leading)
        .navigationBarTitle("Profile")
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

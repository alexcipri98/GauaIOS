//
//  UserImageView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import SwiftUI

struct UserImageView: View {
    @Binding var recortedImage: UIImage?
    var body: some View{
        ZStack {
            if let profileImage = recortedImage {
                Image(uiImage: profileImage)
                    .resizable()
                    .frame(width: 175, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                
            } else if let userImage = NavigationServiceViewModel.shared.userSession?.image {
                Image(uiImage: userImage)
                    .resizable()
                    .frame(width: 175, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 30))
            }
            RoundedRectangle(cornerRadius: 30)
                .strokeBorder(style: StrokeStyle(lineWidth: 3, dash: [15]))
                .foregroundColor(Color.white)
                .frame(width: 175,
                       height: 250)
                .overlay(
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .padding(.trailing, 170)
                        .padding(.bottom, 240)
                )
        }
    }
}

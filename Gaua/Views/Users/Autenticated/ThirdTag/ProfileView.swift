//
//  ProfileView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
        let shouldPresentCropView = profileViewModel.isShowingCropViewController && profileViewModel.selectedImage != nil
        ZStack{
            BackgroundImage(name: "RegisterStep7").opacity(0.9)
            Circle()
                .fill(Colors.purpleColor)
                .frame(width: UIScreen.main.bounds.width * 2.5, height: UIScreen.main.bounds.width * 2.5)
                .offset(y: -UIScreen.main.bounds.width * 1)
                .zIndex(0)
                .opacity(0.7)
            VStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "pencil.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .padding(.leading, 30)

                    Spacer()

                    Button(action: {}) {
                        Image(systemName: "arrowshape.turn.up.right.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding()
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 30)
                }
                .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .center)
                .padding(.vertical, 30)
                

                Button(action: {
                    profileViewModel.isShowingImagePicker = true
                }) {
                    UserImageView(recortedImage: $profileViewModel.recortedImage)
                }
                .sheet(isPresented: $profileViewModel.isShowingImagePicker, onDismiss: profileViewModel.showCrop) {
                    ImagePicker(image: $profileViewModel.selectedImage)
                }
                /* .fullScreenCover(isPresented: Binding<Bool>(get: { shouldPresentCropView },
                 set: { _ in viewModel.isShowingCropViewController = false }),
                 onDismiss: viewModel.loadImage) {
                 CropViewControllerRepresentable(viewModel: self.viewModel)
                 }*/
                GenericText(text: "\(profileViewModel.currentPerson.name), \(profileViewModel.age ?? 0)",
                            color: Color.white)
                
                Button(action: {
                    AuthService().logout()
                }) {
                    Text("logout")
                }
                    //BodyOfProfileView()
                Spacer()
                
            }.padding(.vertical)
                .padding(.horizontal, 50)
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .navigationBarTitle("Profile")
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

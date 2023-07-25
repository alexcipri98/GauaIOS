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
        let shouldPresentCropView = viewModel.isShowingCropViewController && viewModel.selectedImage != nil

        VStack {
            ZStack {
                Button(action: {
                    viewModel.isShowingImagePicker = true
                }) {
                    Image("spanish")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .overlay(
                            Circle()
                                .stroke(Color.white, lineWidth: 5)
                        )
                        .padding(.top, 30)
                        .overlay(
                            Image(systemName: "plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                                .padding(10)
                                .background(Color.white)
                                .clipShape(Circle())
                                .offset(x: 80, y: 80)
                        )
                }
                .sheet(isPresented: $viewModel.isShowingImagePicker, onDismiss: viewModel.showCrop) {
                    ImagePicker(image: $viewModel.selectedImage)
                }
                .sheet(isPresented: Binding<Bool>(get: { shouldPresentCropView },
                                                      set: { _ in viewModel.isShowingCropViewController = false }),
                           onDismiss: viewModel.loadImage) {
                        CropViewControllerRepresentable(viewModel: self.viewModel)
                    }
                
            }
            .frame(maxWidth: .infinity, maxHeight: 350)
            .cornerRadius(20)
            .padding(.horizontal, 20)
            .padding(.bottom, 30)


            Spacer()
        }
        .navigationBarTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

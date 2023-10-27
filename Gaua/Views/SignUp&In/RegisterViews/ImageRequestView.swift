//
//  ImageRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 8/10/23.
//

import SwiftUI

struct ImageRequestView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    @State var isShowingImagePicker: Bool = false
    @State var isShowingCropViewController: Bool = false
    var body: some View {
        let shouldPresentCropView = isShowingCropViewController && registerViewModel.selectedImage != nil
        ZStack{
            BackgroundImage(name: "RegisterStep7")
            
            VStack(alignment: .center) {
                GenericText(text: "register_view_imageRequest".localized,
                             color: Color.white,
                             space: 0)
                .padding(.bottom, 30)
                
                Button(action: {
                    isShowingImagePicker = true
                }) {
                    ZStack {
                        if let profileImage = registerViewModel.recortedImage {
                            Image(uiImage: profileImage)
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
                .sheet(isPresented: $isShowingImagePicker, onDismiss: showCrop) {
                    ImagePicker(image: $registerViewModel.selectedImage)
                }
                .fullScreenCover(isPresented: Binding<Bool>(get: { shouldPresentCropView},
                                                            set: { _ in isShowingCropViewController = false })) {
                    CropViewControllerRepresentable(viewModel: self.registerViewModel)
                }
                GenericButton(action: {
                    registerViewModel.loadImageAndRegister()
                })
                .disabled(registerViewModel.recortedImage == nil)
                .padding(.top, 60)
            }.padding(.vertical)
                .padding(.horizontal, 50)
        }
    }
    func showCrop() {
        self.isShowingCropViewController = true
    }
}

struct ImageRequestView_Previews: PreviewProvider {
    static var previews: some View {
        ImageRequestView(registerViewModel: RegisterViewModel())
    }
}

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
        
        VStack(alignment: .center) {
            GenericText(text: "register_view_imageRequest".localized,
                         color: Color.white,
                         space: 0)
            .padding(.bottom, 30)
            
            Button(action: {
                isShowingImagePicker = true
            }) {
                UserImageView(recortedImage: $registerViewModel.recortedImage)
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
        }
        .padding(.vertical)
        .padding(.horizontal, 50)
        .background(Image("RegisterStep7"))
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

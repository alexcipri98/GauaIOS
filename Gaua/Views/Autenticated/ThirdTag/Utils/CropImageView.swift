//
//  CropImageView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 18/7/23.
//

import SwiftUI
import TOCropViewController

struct CropViewControllerRepresentable: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode
    let viewModel: ProfileViewModel

    func makeUIViewController(context: Context) -> TOCropViewController {
        guard let image = viewModel.selectedImage else {
            fatalError("Image not found")
        }
        
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = context.coordinator
        return configureCropView(cropViewController: cropViewController)
    }

    private func configureCropView(cropViewController: TOCropViewController) -> TOCropViewController {
        cropViewController.customAspectRatio = CGSize(width: 3.5, height: 5)
        cropViewController.aspectRatioPreset = .presetCustom
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.resetAspectRatioEnabled = false
        cropViewController.rotateButtonsHidden = true
        
        return cropViewController
    }

    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, TOCropViewControllerDelegate {
        var parent: CropViewControllerRepresentable

        init(_ parent: CropViewControllerRepresentable) {
            self.parent = parent
        }

        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with rect: CGRect, angle: Int) {
            parent.viewModel.recortedImage = image
            parent.presentationMode.wrappedValue.dismiss()
        }

        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

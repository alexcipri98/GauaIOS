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
    let viewModel: RegisterViewModel

    func makeUIViewController(context: Context) -> TOCropViewController {
        guard let image = viewModel.selectedImage else {
            fatalError("Image not found")
        }
        
        let cropViewController = TOCropViewController(image: image)
        // Establece la relación de aspecto a 9:16
        cropViewController.customAspectRatio = CGSize(width: 9, height: 16)

        // Bloquea el selector para que se mantenga en esta relación de aspecto
        cropViewController.aspectRatioLockEnabled = true
        cropViewController.toolbarPosition = .top // Esto podría mover la barra de herramientas a la parte superior.

        cropViewController.delegate = context.coordinator
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
    
    class OverlayView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setup()
        }
        
        private func setup() {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.layer.borderWidth = 2.0
            self.layer.borderColor = UIColor.white.cgColor
        }
    }

}

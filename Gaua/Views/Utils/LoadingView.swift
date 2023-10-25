//
//  LoadingView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 19/7/23.
//

import SwiftUI
import UIKit
import ImageIO
import SwiftUI

struct LoadingView: View {
    let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    let images: [Image] = (1...53).map { Image("giftloading\($0)") }
    @State private var currentIndex = 0
    
    var body: some View {
        images[currentIndex]
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
            .onReceive(timer) { _ in
                currentIndex = (currentIndex + 1) % images.count
            }
    }
}


/*
struct LoadingView: UIViewRepresentable {
    
    let gifName: String

    func makeUIView(context: UIViewRepresentableContext<LoadingView>) -> UIImageView {
        let imageView = UIImageView()
        if let image = UIImage.gif(name: gifName) {
            imageView.image = image
        }
        imageView.contentMode = .scaleAspectFit 
        imageView.clipsToBounds = true
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: UIViewRepresentableContext<LoadingView>) {}
}

extension UIImage {
    static func gif(name: String) -> UIImage? {
        guard let asset = NSDataAsset(name: name),
              let source = CGImageSourceCreateWithData(asset.data as CFData, nil) else { return nil }

        var images: [UIImage] = []
        let frameCount = CGImageSourceGetCount(source)
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                let image = UIImage(cgImage: cgImage)
                images.append(image)
            }
        }
        return UIImage.animatedImage(with: images, duration: 0.035 * Double(images.count))
    }
}
*/

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

//
//  LoadingView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 19/7/23.
//

import SwiftUI

struct LoadingView: View {
    @State private var imageIndex = 0

    var moonImages = [
        "Moon1",
        "Moon2",
        "Moon3",
        "Moon4",
        "Moon3",
        "Moon4"
    ]

    var body: some View {
        ZStack{
            Image(moonImages[0])
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            VStack {
                Image(moonImages[imageIndex])
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                
            }
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: true) { _ in
                    withAnimation(.linear(duration: 0.15)) {
                        imageIndex = (imageIndex + 1) % moonImages.count
                    }
                }
            }
        }
    }
}


struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}

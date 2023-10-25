//
//  BackgroundImage.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct BackgroundImage: View {
    var name: String
    var body: some View {
        Image(name)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
    }
}

struct BackgroundImage_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImage(name: "RegisterStep1")
    }
}

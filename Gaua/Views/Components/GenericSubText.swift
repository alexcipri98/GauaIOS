//
//  GenericSubText.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/10/23.
//

import SwiftUI

struct GenericSubText: View {
    var text: String
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .font(.system(size: 17))
            .foregroundColor(.white)
            .padding(.bottom, 30)
    }
}

struct GenericSubText_Previews: PreviewProvider {
    static var previews: some View {
        GenericSubText(text: "prueba de texto")
    }
}

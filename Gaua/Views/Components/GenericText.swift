//
//  CustomRegisterText.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct GenericText: View {
    
    var text: String
    var color: Color
    var space: CGFloat? = 0
    
    var body: some View {
        Text(text)
            .fontWeight(.semibold)
            .font(.system(size: 30))
            .foregroundColor(color)
            .padding(.leading, space)
    }
}

struct RegisterText_Previews: PreviewProvider {
    static var previews: some View {
        GenericText(text: "texto",
                           color: Color.blue)
    }
}

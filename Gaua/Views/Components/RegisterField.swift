//
//  RegisterFirstStepField.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct RegisterField: View {
    
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.system(size: 20))
            .foregroundColor(Color(hex: "5B5B5B"))
            .multilineTextAlignment(.center)
            .frame(height: 50, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.75)))
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct RegisterField_Previews: PreviewProvider {
    @State static var defaultText: String = "123456789"

    static var previews: some View {
        RegisterField(placeholder: "+34", text: $defaultText)
    }
}

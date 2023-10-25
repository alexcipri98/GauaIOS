//
//  RegisterGenderButton.swift
//  Gaua
//
//  Created by Alex Ciprián López on 8/10/23.
//

import SwiftUI

struct RegisterGenderButton: View {
    var text: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 18))
                .foregroundColor(Color(hex: "5B5B5B"))
                .frame(maxWidth: .infinity)
                .padding(10)
        }
        .cornerRadius(10)
        .multilineTextAlignment(.center)
        .frame(height: 50, alignment: .center)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(isSelected ? 1:0.75)))
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.black, lineWidth: 1)
        )
    }
}

struct RegisterGenderButton_Previews: PreviewProvider {
    static var previews: some View {
        RegisterGenderButton(text: "prueba", isSelected: true, action: {print("prueba")})
    }
}

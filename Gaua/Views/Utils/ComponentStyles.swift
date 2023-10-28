//
//  ComponentStyles.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ComponentStyles {
    
    // MARK: Generic for all views

    static func customTitleText(text: String, typeOfTitle: Font, color: Color) -> some View {
        Text(text)
            .font(typeOfTitle)
            .fontWeight(.bold)
            .foregroundColor(color)
            .padding(.top)
            .padding(.leading)
    }
    
    static func customButtonWithAction(using closure: @escaping (Person) -> Void, imageName: String, user: Person, color: Color) -> some View {
        Button(action: { _ = closure(user) }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(color)
        }
    }
    
}

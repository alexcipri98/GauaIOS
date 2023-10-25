//
//  CustomRegisterButton.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct GenericButton: View {
    var title: String = "register_view_next".localized
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .bold()
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(10)
        }
        .background(Colors.DarkBlueButtonColor)
        .cornerRadius(10)
        
    }
}

struct RegisterButton_Previews: PreviewProvider {
    static var previews: some View {
        GenericButton(title: "textForButton",
                             action: {
                                print("RegisteButton_Preview")
                            })
    }
}

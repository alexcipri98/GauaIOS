//
//  CustomRegisterButton.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct RegisterButton: View {
    var title: String? = "register_view_next".localized
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text("register_view_next".localized)
                .bold()
                .font(.system(size: 18))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(10)
        }
        .background(Colors.registerButtonColor)
        .cornerRadius(10)
        
    }
}

struct RegisterButton_Previews: PreviewProvider {
    static var previews: some View {
        RegisterButton(title: "textForButton",
                             action: {
                                print("RegisteButton_Preview")
                            })
    }
}

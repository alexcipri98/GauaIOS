//
//  PubSignIn.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import SwiftUI

struct PubsSignInView: View {
    @StateObject var pubsSignInViewModel = PubsSignInViewModel()
    var body: some View {
        VStack(alignment: .center) {
           
            Image("GauaLogo")
                .resizable()
                .frame(width: 225, height: 225)
                .foregroundColor(Color.white)
                .padding(.top)
            
            GenericText(text: "register_view_movileRequest".localized, color: Color.white)
                .padding(.top)
            
           
            RegisterField(placeholder: "email", text: $pubsSignInViewModel.email)
                .padding(.leading, 10)
                .padding(.vertical)
                
            RegisterField(placeholder: "contraseña",
                          text: $pubsSignInViewModel.password)
                .padding(.leading, 10)
                .padding(.vertical)
            
            HStack {
                Image(systemName: "lock")
                    .resizable()
                    .frame(width: 16, height: 24)
                
                Text("register_view_privateSecurityText".localized)
                    .font(.system(size: 12))
            }
            .foregroundColor(Color.white)
            
            GenericButton(action: {
                pubsSignInViewModel.login()
            })
            //.disabled(registerViewModel.phoneNumber == "")
            .padding(.top, 60)
            
            Spacer()
            
        }
        .background(Image("RegisterStep1"))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.horizontal, 50)
    }
}

struct PubSignInView_Previews: PreviewProvider {
    static var previews: some View {
        PubsSignInView()
    }
}

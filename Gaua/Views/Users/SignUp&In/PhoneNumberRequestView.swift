//
//  PhoneNumberRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 24/9/23.
//

import SwiftUI

struct PhoneNumberRequestView: View {
    @StateObject private var registerViewModel = RegisterViewModel()
    @State var goPubsSignIn = false
    var body: some View {
        VStack(alignment: .center) {
            
            Image("GauaLogo")
                .resizable()
                .frame(width: 225, height: 225)
                .foregroundColor(Color.white)
                .padding(.top)
            
            GenericText(text: "register_view_movileRequest".localized, color: Color.white)
                .padding(.top)
            
            HStack {
                RegisterField(placeholder: "+34", text: $registerViewModel.prefix)
                    .frame(width: 70)
                
                RegisterField(placeholder: "register_view_phoneNumber".localized, text: $registerViewModel.phoneNumber)
                    .padding(.leading, 10)
            }
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
                registerViewModel.registerStepOne()
            })
            .disabled(registerViewModel.phoneNumber == "")
            .padding(.top, 50)
            
            GenericSubText(text: "Entrar con cuenta de empresa")
                .underline()
                .padding(.top, 50)
                .onTapGesture {
                    goPubsSignIn = true
                }
            Spacer()
            
        }
        .background(Image("RegisterStep1"))
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.horizontal, 50)
        .navigationDestination(isPresented: $registerViewModel.goVerification) {
            VerificationCodeRequestView(registerViewModel: registerViewModel)
        }
        .navigationDestination(isPresented: $goPubsSignIn) {
            PubsSignInView()
        }
    }
}

struct PhoneNumberRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberRequestView()
    }
}

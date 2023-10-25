//
//  PhoneNumberRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 24/9/23.
//

import SwiftUI

struct PhoneNumberRequestView: View {
    @StateObject private var registerViewModel = RegisterViewModel()

    var body: some View {
        ZStack {
            BackgroundImage(name: "RegisterStep1")
            
            VStack(alignment: .leading) {
                if registerViewModel.isLoading {
                    LoadingView()
                } else {

                    HStack(alignment: .center) {
                        Image("GauaLogo")
                            .resizable()
                            .frame(width: 225, height: 225)
                            .foregroundColor(Color.white)
                    }
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
                    .padding(.top, 60)
                    
                    Spacer()
                }
            }
            .padding(.horizontal, 50)
            .navigationDestination(isPresented: $registerViewModel.goVerification) {
                VerificationCodeRequestView(registerViewModel: registerViewModel)
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }

}

struct PhoneNumberRequestView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberRequestView()
    }
}

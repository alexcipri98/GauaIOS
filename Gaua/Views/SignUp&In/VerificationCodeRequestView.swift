//
//  VerificationCodeRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 26/9/23.
//

import SwiftUI

struct VerificationCodeRequestView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    
    var body: some View {
        ZStack {
            BackgroundImage(name: "RegisterStep2")

            VStack(alignment: .leading) {
                GenericText(
                    text: "register_view_verificationCodeRequest".localized,
                    color: .white,
                    space: 0
                )
                .padding(.bottom, 30)

                RegisterField(
                    placeholder: "register_view_code".localized,
                    text: $registerViewModel.verificationCode
                )

                GenericButton(action: {
                    registerViewModel.registerStepTwo()
                })
                .disabled(registerViewModel.verificationCode.isEmpty)
                .padding(.top, 60)
                .alert(isPresented: $registerViewModel.showSecondStepError) {
                    Alert(
                        title: Text("any_view_error".localized),
                        message: Text(registerViewModel.secondStepError ?? "any_view_unknown_error".localized),
                        dismissButton: .default(Text("any_view_close".localized))
                    )
                }
            }
            .padding(.vertical)
            .padding(.horizontal, 50)
            .navigationDestination(isPresented: $registerViewModel.goName) {
                NameRequestView(registerViewModel: registerViewModel)
            }
        }
    }
}

struct VerificationCodeRequestView_Previews: PreviewProvider {
    static var previews: some View {
        VerificationCodeRequestView(registerViewModel: RegisterViewModel())
    }
}


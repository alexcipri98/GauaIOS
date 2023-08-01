//
//  LoginView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 10/7/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var isRegisterLinkActive = false

    var body: some View {
   
        VStack {
            ComponentStyles.customTitleText(text: "login_view_title".localized,
                                            typeOfTitle: .largeTitle, color: .black)
            
            ComponentStyles.customTextField(variable: $viewModel.email,
                                            text: "request_parameter_email".localized)
            
            ComponentStyles.customSecureField(variable: $viewModel.password,
                                              text: "request_parameter_password".localized)
            
            Button(action: {
                viewModel.login()
            }) {
                ComponentStyles.customTextForButton(text: "login_view_button".localized)            .background(viewModel.isLoggingIn ? Color.gray : Color.blue)

            }
            .padding()
            .disabled(viewModel.isLoggingIn)
            
            Button(action: {
                isRegisterLinkActive = true
            }) {
                Text("login_register_redirect".localized)
                    .padding()
                    .foregroundColor(Color.blue)
            }
            .sheet(isPresented: $isRegisterLinkActive) {
                RegisterView(isRegisterLinkActive: $isRegisterLinkActive)
            }
            
            Spacer()
        }
        .padding()
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("any_view_error".localized),
                message: Text(viewModel.errorText),
                dismissButton: .default(Text("any_view_close".localized))
            )
        }
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

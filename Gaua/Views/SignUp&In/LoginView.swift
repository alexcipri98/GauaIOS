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
            ComponentStyles.customTitleText(text: "Inicio de sesión", typeOfTitle: .largeTitle, color: .black)
            
            ComponentStyles.customTextField(variable: $viewModel.email, text: "Email")
            
            ComponentStyles.customSecureField(variable: $viewModel.password, text: "Contraseña")
            
            Button(action: {
                viewModel.login()
            }) {
                ComponentStyles.customTextForButton(text: "Iniciar sesión")            .background(viewModel.isLoggingIn ? Color.gray : Color.blue)

            }
            .padding()
            .disabled(viewModel.isLoggingIn)
            
            Button(action: {
                isRegisterLinkActive = true
            }) {
                Text("¿Aún no tienes cuenta?")
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
                title: Text("Error"),
                message: Text(viewModel.errorText),
                dismissButton: .default(Text("Cerrar"))
            )
        }
    }
}




struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

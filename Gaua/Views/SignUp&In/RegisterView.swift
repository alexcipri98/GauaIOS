//
//  RegisterView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var viewModel = RegisterViewModel()
    @Binding var isRegisterLinkActive: Bool
    var genders = ["Masculino", "Femenino", "Otro"]
    var sexualOrientations = ["Heterosexual", "Homosexual", "Bisexual"]

    var body: some View {
        ScrollView {
            ComponentStyles.customTitleText(text: "Registro", typeOfTitle: .largeTitle, color: .black)
            
            ComponentStyles.customTextField(variable: $viewModel.email,
                                            text: "Email")
            
            ComponentStyles.customSecureField(variable: $viewModel.password,
                                              text: "Contraseña")
            
            ComponentStyles.customTextField(variable: $viewModel.name,
                                            text: "Nombre")
            
            ComponentStyles.customPicker(text: "Género", values: genders,
                                         variable: $viewModel.gender)
                        
            ComponentStyles.customPicker(text: "Orientación sexual",
                                         values: sexualOrientations,
                                         variable: $viewModel.sexualOrientation)
            
            ComponentStyles.customYearPicker(text: "Año de nacimiento",
                                             variable: $viewModel.yearOfBorn)
            Button(action: {
                viewModel.register()
            }) {
                Text("Crear cuenta")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
        }
        .padding()
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorText),
                dismissButton: .default(Text("Cerrar"))
            )
        }
        .alert(isPresented: $viewModel.showVerify) {
            Alert(
                title: Text("Registro correcto"),
                message: Text("Se ha enviado un email a \(viewModel.email) para que confirme su correo"),
                dismissButton: .default(Text("Cerrar")){
                    isRegisterLinkActive = false
                }
            )
        }
    }
}

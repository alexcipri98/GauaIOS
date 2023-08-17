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
    
    var genders = ["male_gender_parameter".localized,
                   "female_gender_parameter".localized,
                   "other_gender_parameter".localized]
    
    var sexualOrientations = ["male_gender_parameter".localized,
                              "female_gender_parameter".localized,
                              "bisexual_orientation_parameter".localized]

    var body: some View {
        ScrollView {
            
            ComponentStyles.customTitleText(text: "register_view_title".localized, typeOfTitle: .largeTitle, color: .black)
            
            ComponentStyles.customTextField(variable: $viewModel.email,
                                            text: "request_parameter_email".localized)
            .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
            ComponentStyles.customTextError(variable: $viewModel.showEmailError, text: "register_email_error".localized)
            
            ComponentStyles.customSecureField(variable: $viewModel.password,
                                              text: "request_parameter_password".localized)
            ComponentStyles.customTextError(variable: $viewModel.showPasswordError, text: "register_password_error".localized)

            ComponentStyles.customTextField(variable: $viewModel.name,
                                            text: "request_parameter_name".localized)
            ComponentStyles.customTextError(variable: $viewModel.showNameError, text: "register_name_error".localized)

            ComponentStyles.customPicker(text: "request_parameter_gender".localized,
                                         values: genders,
                                         variable: $viewModel.gender)
                        
            ComponentStyles.customPicker(text: "request_parameter_sexualOrientation".localized,
                                         values: sexualOrientations,
                                         variable: $viewModel.genderToShow)
            
            ComponentStyles.customYearPicker(text: "request_parameter_yearOfBirth".localized,
                                             variable: $viewModel.yearOfBorn)
            
        }
        .padding()
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("any_view_error".localized),
                message: Text(viewModel.errorText),
                dismissButton: .default(Text("any_view_close".localized))
            )
        }
        .alert(isPresented: $viewModel.showVerify) {
            Alert(
                title: Text("register_action_correct".localized),
                message: Text("register_email_user".localized),
                dismissButton: .default(Text("any_view_close".localized)){
                    isRegisterLinkActive = false
                }
            )
        }
        Button(action: {
            viewModel.register()
        }) {
            Text("register_view_button".localized)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
        }
        .padding()
    }
}

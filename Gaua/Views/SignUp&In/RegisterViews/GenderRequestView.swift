//
//  GenderRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct GenderRequestView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    var body: some View {
        ZStack {
            BackgroundImage(name: "RegisterStep5")

            VStack(alignment: .leading) {
                GenericText(
                    text: "register_view_genderRequest".localized,
                    color: .white,
                    space: 0
                )
                .padding(.bottom, 30)
                
                Text("register_view_gender".localized)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                VStack {
                    RegisterGenderButton(
                        text: "female_gender_parameter".localized,
                        isSelected: registerViewModel.gender == "female_gender_parameter".localized,
                        action: {
                            registerViewModel.gender = "female_gender_parameter".localized
                        }
                    )
                    RegisterGenderButton(
                        text: "male_gender_parameter".localized,
                        isSelected: registerViewModel.gender == "male_gender_parameter".localized,
                        action: {
                            registerViewModel.gender = "male_gender_parameter".localized
                        }
                    )
                    RegisterGenderButton(
                        text: "other_gender_parameter".localized,
                        isSelected: registerViewModel.gender == "other_gender_parameter".localized,
                        action: {
                            registerViewModel.gender = "other_gender_parameter".localized
                        }
                    )
                }
                
                GenericButton(action: {
                    registerViewModel.goWantedGender = true
                })
                .disabled(registerViewModel.gender.isEmpty)
                .padding(.top, 60)
            }
            .padding(.vertical)
            .padding(.horizontal, 50)
            .navigationDestination(isPresented: $registerViewModel.goWantedGender) {
                ShowedGenderView(registerViewModel: registerViewModel)
            }
        }
    }
}

struct GenderRequestView_Previews: PreviewProvider {
    static var previews: some View {
        GenderRequestView(registerViewModel: RegisterViewModel())
    }
}

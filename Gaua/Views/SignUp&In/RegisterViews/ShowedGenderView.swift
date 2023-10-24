//
//  ShowedGenderView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 4/10/23.
//

import SwiftUI

struct ShowedGenderView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    var body: some View {
        ZStack {
            BackgroundImage(name: "RegisterStep6")

            VStack(alignment: .leading) {
                GenericText(
                    text: "register_view_showGender".localized,
                    color: .white,
                    space: 0
                )
                .padding(.bottom, 30)
                
                Text("register_view_showGenderRequest".localized)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                VStack {
                    RegisterGenderButton(
                        text: "showFemale_gender_parameter".localized,
                        isSelected: registerViewModel.genderToShow == "showFemale_gender_parameter".localized,
                        action: {
                            registerViewModel.genderToShow = "showFemale_gender_parameter".localized
                        }
                    )
                    RegisterGenderButton(
                        text: "showMale_gender_parameter".localized,
                        isSelected: registerViewModel.genderToShow == "showMale_gender_parameter".localized,
                        action: {
                            registerViewModel.genderToShow = "showMale_gender_parameter".localized
                        }
                    )
                    RegisterGenderButton(
                        text: "showBoth_gender_parameter".localized,
                        isSelected: registerViewModel.genderToShow == "showBoth_gender_parameter".localized,
                        action: {
                            registerViewModel.genderToShow = "showBoth_gender_parameter".localized
                        }
                    )
                }
                
                GenericButton(action: {
                    registerViewModel.goImageRequest = true
                })
                .disabled(registerViewModel.genderToShow.isEmpty)
                .padding(.top, 60)
            }
            .padding(.vertical)
            .padding(.horizontal, 50)
            .navigationDestination(isPresented: $registerViewModel.goImageRequest) {
                ImageRequestView(registerViewModel: registerViewModel)
            }
        }
    }
}
struct ShowedGenderView_Previews: PreviewProvider {
    static var previews: some View {
        ShowedGenderView(registerViewModel: RegisterViewModel())
    }
}

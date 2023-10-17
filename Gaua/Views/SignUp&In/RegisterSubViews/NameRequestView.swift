//
//  NameRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 27/9/23.
//

import SwiftUI

struct NameRequestView: View {
    @ObservedObject var registerViewModel: RegisterViewModel
    var body: some View {
        ZStack {
            BackgroundImage(name: "RegisterStep3")

            VStack(alignment: .leading) {
                RegisterText(
                    text: "register_view_nameRequest".localized,
                    color: .white,
                    space: 0
                )
                .padding(.bottom, 30)

                Text("register_view_nameText".localized)
                    .fontWeight(.semibold)
                    .font(.system(size: 17))
                    .foregroundColor(.white)
                    .padding(.bottom, 30)

                RegisterField(
                    placeholder: "register_view_name".localized,
                    text: $registerViewModel.name
                )

                RegisterButton(action: {
                    registerViewModel.goBirthDate = true
                })
                .disabled(registerViewModel.name.isEmpty)
                .padding(.top, 60)
            }
            .padding(.vertical)
            .padding(.horizontal, 50)
            .navigationDestination(isPresented: $registerViewModel.goBirthDate) {
                BirthDateRequestView(registerViewModel: registerViewModel)
            }
        }
    }
}

struct NameRequestView_Previews: PreviewProvider {
    static var previews: some View {
        NameRequestView(registerViewModel: RegisterViewModel())
    }
}

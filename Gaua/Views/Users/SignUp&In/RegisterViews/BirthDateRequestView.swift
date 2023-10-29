//
//  BirthDateRequestView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/9/23.
//

import SwiftUI

struct BirthDateRequestView: View {
    @State var dayOfBorn: String = ""
    @State var monthOfBorn: String = ""
    @State var yearOfBorn: String = ""
    @ObservedObject var registerViewModel: RegisterViewModel
    
    // Variables de estado de enfoque
    @FocusState private var isDayFocused: Bool
    @FocusState private var isMonthFocused: Bool
    @FocusState private var isYearFocused: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            GenericText(
                text: "register_view_birthDateRequest".localized,
                color: .white,
                space: 0
            )
            .padding(.bottom, 60)
            
            HStack {
                RegisterField(
                    placeholder: "DD",
                    text: $dayOfBorn
                )
                .focused($isDayFocused)
                .onChange(of: dayOfBorn) { newValue in
                    if newValue.count > 2 {
                        dayOfBorn = String(newValue.prefix(2))
                    }
                    if dayOfBorn.count == 2 {
                        isMonthFocused = true
                    }
                }
                .frame(width: 70)
                
                RegisterField(
                    placeholder: "MM",
                    text: $monthOfBorn
                )
                .focused($isMonthFocused)
                .onChange(of: monthOfBorn) { newValue in
                    if newValue.count > 2 {
                        monthOfBorn = String(newValue.prefix(2))
                    }
                    if monthOfBorn.count == 2 {
                        isYearFocused = true
                    }
                }
                .frame(width: 70)
                .padding(.leading, 10)
                
                RegisterField(
                    placeholder: "AAAA",
                    text: $yearOfBorn
                )
                .focused($isYearFocused)
                .onChange(of: yearOfBorn) { newValue in
                    if newValue.count > 4 {
                        yearOfBorn = String(newValue.prefix(4))
                    }
                }
                .frame(width: 100)
                .padding(.leading, 10)
            }
            .padding(.vertical)
            
            GenericButton(action: {
                registerViewModel.birthDate = "\(dayOfBorn)/\(monthOfBorn)/\(yearOfBorn)"
                registerViewModel.goGender = true
            })
            .padding(.top, 60)
        }
        .padding(.vertical)
        .padding(.horizontal, 50)
        .background(Image("RegisterStep4"))
        .navigationDestination(isPresented: $registerViewModel.goGender) {
            GenderRequestView(registerViewModel: registerViewModel)
        }
    }
}

struct BirthDateRequestView_Previews: PreviewProvider {
    static var previews: some View {
        BirthDateRequestView(registerViewModel: RegisterViewModel())
    }
}

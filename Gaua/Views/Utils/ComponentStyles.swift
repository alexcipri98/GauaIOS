//
//  ComponentStyles.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ComponentStyles {
    
    static func customTextField(variable: Binding<String>, text: String) -> some View {
        TextField(text, text: variable)
            .textFieldStyle(RoundedTextFieldStyle())
            .padding()
    }
    
    static func customTextForButton(text: String) -> some View {
        Text(text)
            .foregroundColor(.white)
            .padding()
            .cornerRadius(10)
    }
    
    static func customSecureField(variable: Binding<String>, text: String) -> some View {
        SecureField(text, text: variable)
            .textFieldStyle(RoundedTextFieldStyle())
            .padding()
    }
    
    static func customTitleText(text: String, typeOfTitle: Font, color: Color) -> some View {
        Text(text)
            .font(typeOfTitle)
            .fontWeight(.bold)
            .foregroundColor(color)
            .padding(.top)
            .padding(.leading)
    }
    
    static func customPicker(text: String, values: [String], variable: Binding<String>) -> some View {
        VStack{
            Text(text)
            Picker(selection: variable, label: Text(text)) {
                ForEach(values, id: \.self) { value in
                    Text(value)
                }
            }
            .pickerStyle(.segmented)
        }.padding()
    }
    
    static func customYearPicker(text: String, variable: Binding<Int>) -> some View {
        let currentYear = Calendar.current.component(.year, from: Date())
        let dateRange = 1900...currentYear

        return VStack {
            Text(text)
            Picker(selection: variable, label: EmptyView()) {
                ForEach(dateRange, id: \.self) { year in
                    Text(String(year))
                        .tag(year)
                }
            }
            .labelsHidden()
            .pickerStyle(.wheel)
        }
        .padding()
    }
    
    static func customButtonWithAction(using closure: @escaping (Person) -> Void, imageName: String, user: Person, color: Color) -> some View {
        Button(action: { _ = closure(user) }) {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                .foregroundColor(color)
        }
    }
    
    static func customImageOfUser() -> some View {
        let image: Image
        if let uiImage = UserSession.shared.currentUser?.image {
            image = Image(uiImage: uiImage)
        } else {
            image = Image("spanish")
        }
        return image.resizable().aspectRatio(contentMode: .fill)
    }
    
}

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
    }
}

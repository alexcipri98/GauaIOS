//
//  CardView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 14/7/23.
//

import SwiftUI

struct CardView: View {
    @State private var translation: CGSize = .zero
    @State var showAllDescription: Bool = false
    @Binding var users: [Person]
    let user: Person
    let methodToRemoveLastUser: (Person) -> Void
    let methodToLikeUser: (Person) -> Void

    var body: some View {
        ZStack {
            if let image = user.image {
                Image(uiImage: image)
                    .resizable()
            }
            VStack(alignment: .leading) {
                Spacer()
                HStack{
                        ComponentStyles.customTitleText(text: user.name + " " + String(user.yearOfBorn), typeOfTitle: .title, color: .white)
                    Spacer()
                }
                if showAllDescription {
                    ComponentStyles.customTitleText(text: "Nacido en San Sebastian, viviendo en Madrid desde hace dos años, disfruto el día a día, me gusta bailar y los animales", typeOfTitle: .subheadline, color: .white)
                        .opacity(showAllDescription ? 1.0 : 0.0)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showAllDescription.toggle()
                            }
                        }
                } else {
                    ComponentStyles.customTitleText(text: "Nacido en San Sebastian, vivi...", typeOfTitle: .subheadline, color: .white)
                        .opacity(showAllDescription ? 0.0 : 1.0)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                showAllDescription.toggle()
                            }
                        }
                }
                HStack {
                    ComponentStyles.customButtonWithAction(using: methodToRemoveLastUser, imageName: "trash.circle", user: user, color: .red)
                    Spacer()
                    ComponentStyles.customButtonWithAction(using: methodToLikeUser, imageName: "flame.circle", user: user, color: .green)
                }.padding()
            }.background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.black.opacity(0.2), Color.black.opacity(1)]),
                    startPoint: UnitPoint(x: 0.5, y: 0.5),
                    endPoint: UnitPoint(x: 0.5, y: 1)
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Asegura que el gradiente cubra toda la tarjeta
            )
        }
        .cornerRadius(20)
        .shadow(radius: 5)
    }
}

//
//  SinglePubView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 29/10/23.
//

import SwiftUI
import UIKit

struct SinglePubView: View {
    var uiImage: UIImage
    var nombre: String
    var promocionado: Bool? = false

    var body: some View {
        Image(uiImage: uiImage)
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .padding(.horizontal)
            .overlay(
                GenericText(text: nombre,
                            color: Color.white)
                    .shadow(color: .black, radius: 0, x: 1, y: 1)
                    .shadow(color: .black, radius: 0, x: -1, y: 1)
                    .shadow(color: .black, radius: 0, x: 1, y: -1)
                    .shadow(color: .black, radius: 0, x: -1, y: -1)
                    .padding(.bottom),
                alignment: .bottom
            )
            .overlay(
                Group {
                    if promocionado ?? false {
                        GenericSubText(text: "Promocionado")
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 0, x: 1, y: 1)
                            .shadow(color: .black, radius: 0, x: -1, y: 1)
                            .shadow(color: .black, radius: 0, x: 1, y: -1)
                            .shadow(color: .black, radius: 0, x: -1, y: -1)
                            .padding(4)
                            .padding(.top)
                            .padding(.leading, 30)
                    }
                },
                alignment: .topLeading
            )
    }
}


struct SinglePubView_Previews: PreviewProvider {
    static var previews: some View {
        SinglePubView(uiImage: UIImage(named: "TeatroKapital")!, nombre: "Teatro Kapital")
    }
}

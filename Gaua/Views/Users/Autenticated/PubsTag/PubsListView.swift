//
//  PubsListView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 28/10/23.
//

import SwiftUI

struct PubsListView: View {
    @State private var searchText: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            GenericText(text: "¿Ya tienes plan?",
                        color: Color.white)
            
            GenericSubText(text: "Saca ya la entrada para la discoteca y ahórrate la cola:")
            
            TextField("Ciudad o CP", text: $searchText)
                .padding(.horizontal)
                .frame(height: 44)
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                .foregroundColor(.black)
                        
            
            SinglePubView(uiImage: UIImage(named: "TeatroKapital")!,
                          nombre: "Teatro Kapital",
                          promocionado: true)
            
            Spacer()
        }
        .padding(.vertical, 50)
        .padding(.horizontal)
        .background(Image("RegisterStep2"))
    }
}

struct PubsListView_Previews: PreviewProvider {
    static var previews: some View {
        PubsListView()
    }
}

//
//  TitleRowView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import SwiftUI

struct TitleRowView: View {
    var image = Image("spanish")
    var name = "sara"
    var body: some View {
        HStack(spacing: 20){
            image.resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50)
                .cornerRadius(50)
            
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title).bold()
                
                Text("Online")
                    .font(.caption)
                    .foregroundColor(.gray)
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.padding()
        
    }
}

struct TitleRowView_Previews: PreviewProvider {
    static var previews: some View {
        TitleRowView().background(Color("Peach"))
    }
}

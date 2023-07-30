//
//  TitleRowView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import SwiftUI

struct TitleRowView: View {
    @EnvironmentObject var chatViewModel: ChatViewModel

    var body: some View {
        HStack(spacing: 20){
            if let image = chatViewModel.otherPerson.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            } else {
                ComponentStyles.customDefaultUserImage()
                    .frame(width: 50, height: 50)
                    .cornerRadius(50)
            }
            VStack(alignment: .leading) {
                Text(chatViewModel.otherPerson.name)
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

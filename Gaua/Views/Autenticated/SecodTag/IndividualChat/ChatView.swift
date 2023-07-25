//
//  ChatView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    
    var body: some View {
        VStack {
            VStack{
                TitleRowView()
                
                ScrollView{
                    ForEach(viewModel.messages, id: \.id) { message in
                        MessageBubble(message: message)
                    }
                }.padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
            }
            .background(Color("Peach"))
            
            MessageFieldView().environmentObject(viewModel)
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

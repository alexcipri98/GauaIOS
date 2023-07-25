//
//  ChatView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ChatView: View {
    @StateObject var viewModel = ChatViewModel()
    var messageArray = ["Hello you", "How are you doing?", "I´ve been buildng Gaua App"]
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

struct messagesView: View {
    var body: some View{
        ScrollView {
            ForEach(0..<10, id: \.self) { num in
                VStack {
                    HStack(spacing: 16) {
                        Image(systemName: "person.fill")
                            .font(.system(size: 32))
                            .padding(8)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                        .stroke(Color(.label), lineWidth: 1)
                            )
                        
                        
                        VStack(alignment: .leading) {
                            Text("Username")
                                .font(.system(size: 16, weight: .bold))
                            Text("Message sent to user")
                                .font(.system(size: 14))
                                .foregroundColor(Color(.lightGray))
                        }
                        Spacer()
                        
                        Text("22d")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    Divider()
                        .padding(.vertical, 8)
                }.padding(.horizontal)
                
            }.padding(.bottom, 50)
        }
    }
}

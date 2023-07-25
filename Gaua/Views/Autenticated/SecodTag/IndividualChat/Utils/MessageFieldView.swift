//
//  MessageFieldView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import SwiftUI

struct MessageFieldView: View {
    @EnvironmentObject var chatViewModel: ChatViewModel
    @State private var message = ""
    
    var body: some View {
        HStack{
            customTextField(placeholder: Text("Enter your message here"), text: $message)
            
            Button {
                chatViewModel.sendMessage(text: message, toMatchDocumentID: "J3OS7Y5uoZMUVWAeXXEqEdsOTl63_J3OS7Y5uoZMUVWAeXXEqEdsOTl63")
                message = ""
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Peach"))
                    .cornerRadius(50)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
    }
}

struct customTextField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View{
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .opacity(0.5)
            }
            TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
        }
    }
    
}

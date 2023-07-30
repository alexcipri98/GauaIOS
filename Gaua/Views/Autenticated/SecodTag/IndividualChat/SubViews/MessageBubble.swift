//
//  MessageBubble.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import SwiftUI

struct MessageBubble: View {
    var message: Message
    @State private var showTime = true
    
    var body: some View {
        if let currentUser = UserSession.shared.currentUser {
            let isSendedMessage = (message.sendedByID == currentUser.id)
            let alignmentForMessage: Alignment = isSendedMessage ? .trailing : .leading
            
            VStack(alignment: isSendedMessage ? .trailing : .leading) {
                HStack {
                    Text(message.text)
                        .padding()
                        .background(isSendedMessage ? Color("Peach") : Color("Gray"))
                        .cornerRadius(30)
                }
                .frame(maxWidth: 300, alignment: alignmentForMessage)
                .onTapGesture {
                    showTime.toggle()
                }
                if showTime {
                    Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                        .padding(isSendedMessage ? .trailing : .leading, 25)
                }
            }
            .frame(maxWidth: .infinity, alignment: alignmentForMessage)
            .padding(isSendedMessage ? .trailing : .leading, 10)
        } else {
            EmptyView()
            #warning("En lugar de una vista vacia tendría que mostrarse un error")
        }
    }
}

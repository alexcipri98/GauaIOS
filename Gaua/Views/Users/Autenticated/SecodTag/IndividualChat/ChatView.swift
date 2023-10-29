//
//  ChatView.swift
//  Gaua
//
//  Created by Alex Ciprián López on 12/7/23.
//

import SwiftUI

struct ChatView: View {
    private var forDocument: String

    @StateObject private var viewModel: ChatViewModel

    init(forDocument document: String, otherPerson: Person) {
        self.forDocument = document
        _viewModel = StateObject(wrappedValue: ChatViewModel(forDocument: document, otherPerson: otherPerson))
    }
    
    var body: some View {
        VStack {
            VStack{
                TitleRowView().environmentObject(viewModel)

                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(viewModel.messages, id: \.id) { message in
                            MessageBubble(message: message)
                        }
                        .onChange(of: viewModel.messages.count) { _ in
                            if let lastMessage = viewModel.messages.last {
                                proxy.scrollTo(lastMessage.id, anchor: .bottom)
                            }
                        }
                    }
                    .padding(.top, 10)
                    .background(.white)
                    .cornerRadius(30, corners: [.topLeft, .topRight])
                }
            }
            .background(Color("Peach"))

            MessageFieldView().environmentObject(viewModel)
        }
    }
}

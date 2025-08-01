//
//  ChatViewModel.swift
//  Gaua
//
//  Created by Alex Ciprián López on 22/7/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatViewModel: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published var showError: Bool = false
    @Published var errorText: String = ""
    private var chatService = ChatService()
    public var matchID: String
    public var otherPerson: Person
    typealias MessageResult = Result<[Message], Error>

    func processMessagesResult(_ result: MessageResult) {
        switch result {
        case .success(let messages):
            self.messages = messages
        case .failure(let error):
            self.errorText = error.localizedDescription
            self.showError = true
        }
    }


    init(forDocument document: String, otherPerson: Person) {
        self.matchID = document
        self.otherPerson = otherPerson
        getMessages(forDocument: document)
    }
    
    func getMessages(forDocument documentID: String) {
        chatService.getConversationIDs(forDocument: documentID, onSuccess: { conversationIDs in
            self.chatService.getMessages(conversationIDs: conversationIDs, onSuccess: { messages in
                self.processMessagesResult(.success(messages))
            }, onFailure: { error in
                self.isNSError(error: error)
            })
        }, onFailure: { error in
            self.isNSError(error: error)
        })
    }
    
    func sendMessage(text: String, toMatchDocumentID matchDocumentID: String) {
        let newMessage = Message(id: "\(UUID())", text: text, sendedByID: UserSession.shared.currentUser!.id, timestamp: Date())
        chatService.sendMessage(newMessage: newMessage,
                                toMatchDocumentID: matchDocumentID,
                                onFailure: { error in
                                    self.isNSError(error: error)
                                })
    }
    
    private func isNSError(error: (any Error)?) {
        if let error = error as NSError? {
            processMessagesResult(.failure(error))
        } else {
            processMessagesResult(.failure(NSError(domain: "", code: 0, userInfo: nil)))
        }
    }
}

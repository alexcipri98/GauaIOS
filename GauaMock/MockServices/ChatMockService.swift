//
//  ChatService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 25/7/23.
//

import Foundation

class ChatService {

    func getConversationIDs(forDocument documentID: String, onSuccess: @escaping ([String]) -> Void, onFailure: @escaping (Error?) -> Void) {
        onSuccess(["123456"])
    }
    
    func getMessages(conversationIDs: [String], onSuccess: @escaping ([Message]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let m = Message(id: "123456", text: "hola", sendedByID: "123", timestamp: Date())
        onSuccess([m])
    }

    
    func sendMessage(newMessage: Message, toMatchDocumentID matchDocumentID: String, onFailure: @escaping (Error) -> Void) {
        print("sendMessageMock")
    }

}

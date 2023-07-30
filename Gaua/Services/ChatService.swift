//
//  ChatService.swift
//  Gaua
//
//  Created by Alex Ciprián López on 25/7/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ChatService {
    let db = Firestore.firestore()

    func getConversationIDs(forDocument documentID: String, onSuccess: @escaping ([String]) -> Void, onFailure: @escaping (Error?) -> Void) {
        db.collection("matches").document(documentID).addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("\u{274C} Error fetching document: \(error)")
                onFailure(error)
                return
            }
            
            guard let documentData = documentSnapshot?.data(),
                  let conversationIDs = documentData["conversation"] as? [String] else {
                print("\u{274C} Error: Conversation data not found or not in the expected format.")
                onFailure(error)
                return
            }
            
            print("\u{1F44C} Conversation ID retrieved")
            onSuccess(conversationIDs)
        }
    }
    
    func getMessages(conversationIDs: [String], onSuccess: @escaping ([Message]) -> Void, onFailure: @escaping (Error?) -> Void) {
        let chunkedConversationIDs = conversationIDs.chunked(into: 10)
        
        var messages = [Message]()
        
        for chunk in chunkedConversationIDs {
            self.db.collection("messages")
                .whereField("id", in: chunk)
                .getDocuments { querySnapshot, error in
                    if let error = error {
                        print("\u{274C} Error fetching documents: \(error.localizedDescription)")
                        onFailure(error)
                        return
                    }
                    
                    guard let documents = querySnapshot?.documents else {
                        print("\u{274C} No documents found")
                        onFailure(nil)
                        return
                    }
                    
                    let additionalMessages = documents.compactMap { document -> Message? in
                        do {
                            return try document.data(as: Message.self)
                        } catch {
                            print("\u{274C} Error decoding document into Message: \(error)")
                            return nil
                        }
                    }
                    
                    messages += additionalMessages
                    messages.sort { $0.timestamp < $1.timestamp }
                    
                    if chunk == chunkedConversationIDs.last {
                        print("\u{1F44C} Messages retrieved succesfull")
                        onSuccess(messages)
                    }
                }
        }
    }

    
    func sendMessage(newMessage: Message, toMatchDocumentID matchDocumentID: String, onFailure: @escaping (Error) -> Void) {
        let messageRef = db.collection("messages").document(newMessage.id)
        
        do {
            try messageRef.setData(from: newMessage) { error in
                if let error = error {
                    print("\u{274C} Error adding message to Firestore: \(error.localizedDescription)")
                    onFailure(error)
                } else {
                    let messageID = messageRef.documentID
                    self.db.collection("matches").document(matchDocumentID).updateData([
                        "conversation": FieldValue.arrayUnion([messageID])
                    ]) { error in
                        if let error = error {
                            print("\u{274C} Error updating match document: \(error.localizedDescription)")
                            onFailure(error)
                        } else {
                            print("\u{1F44C} Message sent successfully.")
                        }
                    }
                }
            }
        } catch {
            print("\u{274C} Error adding message to Firestore: \(error.localizedDescription)")
            onFailure(error)
        }
    }

}

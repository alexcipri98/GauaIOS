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
    let db = Firestore.firestore()
    
    init(){
        getMessages(forDocument: "J3OS7Y5uoZMUVWAeXXEqEdsOTl63_J3OS7Y5uoZMUVWAeXXEqEdsOTl63")
    }
    
    func getMessages(forDocument documentID: String) {
        db.collection("matches").document(documentID).addSnapshotListener { documentSnapshot, error in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            guard let documentData = documentSnapshot?.data(),
                  let conversationIDs = documentData["conversation"] as? [String] else {
                print("Error: Conversation data not found or not in the expected format.")
                return
            }
            
            let chunkedConversationIDs = conversationIDs.chunked(into: 10) // Divide en lotes de 10 elementos
            
            self.db.collection("messages")
                .whereField("id", in: chunkedConversationIDs[0])
                .addSnapshotListener { querySnapshot, error in
                    guard let documents = querySnapshot?.documents else {
                        print("Error fetching documents: \(String(describing: error))")
                        return
                    }
                    
                    self.messages = documents.compactMap { document -> Message? in
                        do {
                            return try document.data(as: Message.self)
                        } catch {
                            print("Error decoding document into Message: \(error)")
                            return nil
                        }
                    }
                    self.messages.sort { $0.timestamp < $1.timestamp }
                    
                    for i in 1..<chunkedConversationIDs.count {
                        self.db.collection("messages")
                            .whereField("id", in: chunkedConversationIDs[i])
                            .getDocuments { querySnapshot, error in
                                guard let documents = querySnapshot?.documents else {
                                    print("Error fetching documents: \(String(describing: error))")
                                    return
                                }
                                
                                let additionalMessages = documents.compactMap { document -> Message? in
                                    do {
                                        return try document.data(as: Message.self)
                                    } catch {
                                        print("Error decoding document into Message: \(error)")
                                        return nil
                                    }
                                }
                                self.messages += additionalMessages
                                self.messages.sort { $0.timestamp < $1.timestamp }
                            }
                    }
                }
        }
    }
    
    func sendMessage(text: String, toMatchDocumentID matchDocumentID: String) {
        let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
        
        do {
            let messageRef = db.collection("messages").document(newMessage.id)
            try messageRef.setData(from: newMessage)
            let messageID = messageRef.documentID
            
            db.collection("matches").document(matchDocumentID).updateData([
                "conversation": FieldValue.arrayUnion([messageID])
            ]) { error in
                if let error = error {
                    print("Error updating match document: \(error.localizedDescription)")
                } else {
                    print("Message sent successfully.")
                }
            }
        } catch {
            print("Error adding message to Firestore: \(error.localizedDescription)")
        }
    }

}

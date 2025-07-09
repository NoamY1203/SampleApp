//
//  FirebaseManager.swift
//  JournalMe
//
//  Created by Noam Yakov on 12/1/24.
//

import Foundation
import FirebaseFirestore

class FirebaseManager {
    private let db = Firestore.firestore()

    func saveJournalEntry(title: String, body: String, completion: @escaping (Error?) -> Void) {
        let entry = [
            "title": title,
            "body": body,
            "timestamp": Timestamp(date: Date())
        ] as [String : Any]
        
        db.collection("journalEntries").addDocument(data: entry) { error in
            completion(error)
        }
    }
}

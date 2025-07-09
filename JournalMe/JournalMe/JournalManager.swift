//
//  JournalManager.swift
//  JournalMe
//
//  Created by Noam Yakov on 12/1/24.
//

import Foundation

// Model for a Journal Entry
struct JournalEntry: Identifiable, Codable {
    let id: UUID
    let title: String
    let body: String
    let date: Date
}

// Singleton Manager for Journal Entries
class JournalManager: ObservableObject {
    static let shared = JournalManager()
    
    @Published private var entries: [JournalEntry] = []
    
    private init() {
        loadEntries() // Load the entries when the manager is created
    }
    
    // Add a new journal entry
    func addEntry(title: String, body: String) {
        let newEntry = JournalEntry(id: UUID(), title: title, body: body, date: Date())
        entries.append(newEntry)
        saveEntries()
    }
    
    // Get all journal entries
    func getEntries() -> [JournalEntry] {
        return entries
    }
    
    // Save entries to UserDefaults
    private func saveEntries() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(entries) {
            UserDefaults.standard.set(data, forKey: "journalEntries")
        }
    }
    
    // Load entries from UserDefaults
    private func loadEntries() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "journalEntries"),
           let loadedEntries = try? decoder.decode([JournalEntry].self, from: data) {
            entries = loadedEntries
        }
    }
}

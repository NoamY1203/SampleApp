//
//  JournalEntryView.swift
//  JournalMe
//
//  Created by Noam Yakov on 12/1/24.
//

import SwiftUI

struct JournalEntryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title = ""
    @State private var bodyText = ""
    @State private var showAlert = false

    var selectedPrompt: String?
    private let firebaseManager = FirebaseManager()

    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .font(.headline)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)

            TextEditor(text: $bodyText)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(8)
                .frame(minHeight: 200)

            Spacer()

            Button("Done") {
                saveJournalEntry()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(8)
        }
        .padding()
        .onAppear {
            if let prompt = selectedPrompt {
                bodyText = prompt
            }
        }
        .alert("Entry Saved", isPresented: $showAlert) {
            Button("OK") {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }

    private func saveJournalEntry() {
        let entryTitle = title.trimmingCharacters(in: .whitespaces)
        let entryBody = bodyText.trimmingCharacters(in: .whitespaces)

        guard !entryTitle.isEmpty, !entryBody.isEmpty else {
            // Optional: Show an alert for invalid input
            return
        }

        // Save to Firebase
        firebaseManager.saveJournalEntry(title: entryTitle, body: entryBody) { error in
            if error == nil {
                // Save locally using JournalManager
                JournalManager.shared.addEntry(title: entryTitle, body: entryBody)
                
                // Show confirmation
                showAlert = true
            }
        }
    }

}

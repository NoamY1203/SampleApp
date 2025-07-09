//
//  PromptSelectionView.swift
//  JournalMe
//
//  Created by Noam Yakov on 12/1/24.
//

import SwiftUI

struct PromptSelectionView: View {
    @State private var prompts = [
        "What made you smile today?",
        "Describe your perfect day.",
        "What are you most grateful for?",
        "What is a challenge you overcame recently?",
        "Write about a memorable experience."
    ]
    @State private var selectedPrompt: String?
    @State private var showJournalEntry = false

    var body: some View {
        NavigationStack {
            VStack {
                List(prompts, id: \.self) { prompt in
                    Button(action: {
                        selectedPrompt = prompt
                        showJournalEntry = true
                    }) {
                        Text(prompt)
                    }
                }
                Button(action: {
                    selectedPrompt = nil
                    showJournalEntry = true
                }) {
                    Text("Free Write")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            .navigationTitle("Choose a Prompt")
            .navigationDestination(isPresented: $showJournalEntry) {
                JournalEntryView(selectedPrompt: selectedPrompt)
            }
        }
    }
}

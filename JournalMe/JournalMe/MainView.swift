//
//  MainView.swift
//  JournalMe
//
//  Created by Noam Yakov on 11/30/24.
//

import SwiftUI

struct MainView: View {
    @State private var entries: [JournalEntry] = []

    var body: some View {
        NavigationView {
            VStack {
                // Add the title
                Text("JournalMe")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()

                if entries.isEmpty {
                    Text("No entries yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List(entries) { entry in
                        NavigationLink(destination: JournalDetailView(entry: entry)) {
                            VStack(alignment: .leading) {
                                Text(entry.title)
                                    .font(.headline)
                                Text(entry.body)
                                    .font(.subheadline)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                Text("Date: \(entry.date, formatter: dateFormatter)")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }

                Spacer()

                NavigationLink(destination: PromptSelectionView()) {
                    ZStack {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 70, height: 70)
                        Text("+")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .shadow(radius: 5)
                }
                .padding(.bottom, 40)
            }
            .navigationBarHidden(true)
            .onAppear(perform: loadEntries)
        }
    }

    func loadEntries() {
        entries = JournalManager.shared.getEntries()
    }
}


//
//  JournalDetailView.swift
//  JournalMe
//
//  Created by Noam Yakov on 12/3/24.
//

import SwiftUI

struct JournalDetailView: View {
    let entry: JournalEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(entry.title)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(entry.body)
                .font(.body)
                .padding()

            Text("Date: \(entry.date, formatter: dateFormatter)")
                .font(.footnote)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("Journal Entry")
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

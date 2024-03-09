//
//  JournalEntryRow.swift
//  journal
//
//  Created by Mickson Bossman on 06.03.2024.
//

import SwiftUI

struct JournalEntryRow: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading){
                Text("Date: March 6, 2024")
                    .font(.headline)
                Text("Gratitude journal content goes here.")
                    .font(.subheadline)
                    .lineLimit(2)
            }
        }
        .padding(.vertical, 8)
    }
}

#Preview {
    JournalEntryRow()
}

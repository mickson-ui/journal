//
//  JournalList.swift
//  journal
//
//  Created by Mickson Bossman on 06.03.2024.
//

import SwiftUI
import CoreData

struct JournalList: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var journal: FetchedResults<Journal>
    
    @State private var showAddJournalEntryView = false
    
    var body: some View {
        NavigationView{
            List{
                ForEach(journal){ journal in
                    ZStack {
                        NavigationLink(destination: EditJournalEntryView(journal: journal)){
                            EmptyView()
                        }
                        HStack{
                            VStack(alignment: .leading){
                                if let imageData = journal.imageData,
                                   let uiImage = UIImage(data: imageData) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(height: 150)
                                        .cornerRadius(8)
                                }
                                if let content = journal.content {
                                    Text(content)
                                        .font(.headline)
                                }
                                
                                if let mood = journal.mood {
                                    Text(mood)
                                        .font(.subheadline)
                                        .lineLimit(2)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .onDelete(perform: deleteJournal)
            }
            .listStyle(.plain)
            .navigationTitle("Mindful Journal")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        showAddJournalEntryView.toggle()
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                            .foregroundColor(.red)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading){
                    EditButton()
                }
            }
        }
        .sheet(isPresented: $showAddJournalEntryView){
            AddJourneyEntryView()
        }
    }
    
    private func deleteJournal(offsets: IndexSet){
        withAnimation {
            offsets.map{journal[$0]}.forEach(managedObjectContext.delete)
            DataController().save(context: managedObjectContext)
        }
    }
}

#Preview {
    JournalList()
}

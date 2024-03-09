//
//  EditJournalEntryView.swift
//  journal
//
//  Created by Mickson Bossman on 07.03.2024.
//

import SwiftUI

struct EditJournalEntryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var journal: FetchedResults<Journal>.Element
    
    @State private var content = ""
    @State private var mood = Mood.happy
    @State private var selectedImage: UIImage?
    
    @State private var isImagePickerPresented = false
    
    var body: some View {
        VStack{
            Form{
                Section(header: Text("Attach Media")){
                    Button("Change Image"){
                        isImagePickerPresented.toggle()
                    }
                    .sheet(isPresented: $isImagePickerPresented) {
                        ImagePicker(image: $selectedImage)
                    }
                    if let image = selectedImage{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding(.vertical, 5)
                    }
                    
                }
                
                Section(header: Text("Mood")){
                    Picker("Select Mood", selection: $mood){
                        ForEach(Mood.allCases, id: \.self){ mood in
                            Text(mood.rawValue).tag(mood)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section(header: Text("Journal Content")){
                    TextEditor(text: $content)
                        .frame(minHeight: 100)
                }
                HStack{
                    Spacer()
                    Button("Save Edited Journal"){
                        DataController().editJournal(journal: journal,
                            content: content,
                            mood: mood.rawValue,
                            imageData: selectedImage!,
                            context: managedObjectContext
                        )
                        
                        dismiss()
                    }
                    .foregroundColor(.red)
                    Spacer()
                }
            }
            .navigationBarTitle("Edit Journal", displayMode: .inline)
            .onAppear{
                content = journal.content ?? ""
                mood = Mood(rawValue: journal.mood ?? "") ?? Mood.happy
                if let imageData = journal.imageData,
                   let uiImage = UIImage(data: imageData){
                    selectedImage = uiImage
                }
            }
        }
    }
}

//#Preview {
//    EditJournalEntryView()
//}

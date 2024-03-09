//
//  AddJourneyEntryView.swift
//  journal
//
//  Created by Mickson Bossman on 06.03.2024.
//

import SwiftUI

struct AddJourneyEntryView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var content = ""
    @State private var mood = Mood.happy
    @State private var selectedImage: UIImage?
    
    @State private var isImagePickerPresented = false
    
    var body: some View {
        NavigationView{
            
            VStack{
                Form{
                    Section(header: Text("Attach Media")){
                        Button("Add Image"){
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
                        Button("Save Journal"){
                            DataController().addJournal(
                                content: content,
                                mood: mood.rawValue,
                                imageData: selectedImage!,
                                context: managedObjectContext
                            )
                            
                            dismiss()
                        }
                        Spacer()
                    }
                }
                .navigationBarTitle("Add Journal", displayMode: .inline)
            }
        }
    }
}

enum Mood: String, CaseIterable{
    case happy = "happy"
    case neutral = "Neutral"
    case sad = "Sad"
}

#Preview {
    AddJourneyEntryView()
}

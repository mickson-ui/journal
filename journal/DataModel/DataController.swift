//
//  DataController.swift
//  journal
//
//  Created by Mickson Bossman on 07.03.2024.
//

import Foundation
import CoreData
import UIKit

class DataController: ObservableObject{
    let container = NSPersistentContainer(name: "JournalModel")
    
    init(){
        container.loadPersistentStores{ desc, error in
            if let error = error{
                print("Failed to load the data \(error.localizedDescription)")
            }
            
        }
    }
    
    func save(context: NSManagedObjectContext){
        do{
            try context.save()
            print("Data saved!!!")
        }catch{
            print("Data not saved....")
        }
    }
    
    func addJournal(content: String, mood: String, imageData: UIImage, context: NSManagedObjectContext){
        let journal = Journal(context: context)
        journal.id = UUID()
        journal.date = Date()
        journal.content = content
        journal.mood = mood
        
        if let imageData = imageData.jpegData(compressionQuality: 1.0){
            journal.imageData = imageData
        }
        
        save(context: context)
    }
    
    func editJournal(journal: Journal, content: String, mood: String, imageData: UIImage, context: NSManagedObjectContext){
        journal.date = Date()
        journal.content = content
        journal.mood = mood
        
        if let imageData = imageData.jpegData(compressionQuality: 1.0){
            journal.imageData = imageData
        }
        
        save(context: context)
    }
    
}

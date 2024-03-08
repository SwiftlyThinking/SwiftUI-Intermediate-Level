//
//  CoreDataManager.swift
//  SwiftUI-Intermediate-Level
//
//  Created by Mykyta Kuzminov on 08.03.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    
    
    static let shared = CoreDataManager()
    
    private let container: NSPersistentContainer
    private var context: NSManagedObjectContext
    
    private init() {
        container = NSPersistentContainer(name: "RelationshipsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Loading stores error. \(error.localizedDescription)")
            }
        }
        
        context = container.viewContext
    }
    
    func fetchData<T: NSManagedObject>(entityType: T.Type, entityName: String) -> [T]? {
        let request = NSFetchRequest<T>(entityName: entityName)
        
        do {
            return try context.fetch(request)
        } catch let error {
            print("Fetching data error. \(error.localizedDescription)")
        }
        
        return nil
    }
    
    func addData<T: NSManagedObject>(entityType: T.Type, setupClouser: (T) -> ()) {
        let newItem = T(context: context)
        setupClouser(newItem)
        
        saveData()
    }
    
    func removeData<T: NSManagedObject>(entity: T) {
        context.delete(entity)
        
        saveData()
    }
    
    func saveData() {
        do {
            try context.save()
        } catch let error {
            print("Saving data error. \(error.localizedDescription)")
        }
    }
}

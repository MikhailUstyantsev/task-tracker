//
//  CoreDataManager.swift
//  EventCountdownApp - MVVM-C
//
//  Created by Mikhail Ustyantsev on 26.11.2022.
//

import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "TaskTracker")
        persistentContainer.loadPersistentStores { _, error in
            print(error?.localizedDescription ?? "")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    
    func get<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        } catch {
            print(error)
        }
        return nil
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
          return try moc.fetch(fetchRequest)
                
        } catch {
            print(error)
            return []
        }
    }
    
    func save() {
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    
    
    func deleteItem(_ task: Task) {
        moc.delete(task)
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    func checkIfItemExist(title: String) -> Bool {
        let request = NSFetchRequest<Task>(entityName: "Task")
        request.fetchLimit = 1
        request.predicate = NSPredicate(format: "title == %@", title)
        do {
            let count = try moc.count(for: request)
            if count > 0 {
                return true
            } else {
               return false
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return false
        }
    }
    
    
    
    
}

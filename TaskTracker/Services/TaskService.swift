//
//  TaskManager.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 31.07.2023.
//

import Foundation
import CoreData

protocol TaskServiceProtocol {
    func perform(_ action: TaskService.TaskAction, data: TaskService.TaskInputData)
    func getTask(_ id: NSManagedObjectID) -> Task?
    func getTasks() -> [Task]
}


final class TaskService: TaskServiceProtocol {
    
    struct TaskInputData {
        let name: String
        let date: Date
        let isChecked: Bool
    }
    
    enum TaskAction {
        case add
        case update(Task)
    }
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
    }
    
    
    func perform(_ action: TaskAction, data: TaskInputData) {
        var task: Task
        switch action {
        case .add: task = Task(context: coreDataManager.moc)
        case .update(let taskToUpdate):
            task = taskToUpdate
        }
            task.setValue(data.name, forKey: "title")
            task.setValue(data.date, forKey: "date")
            task.setValue(data.isChecked, forKey: "isChecked")
            
            coreDataManager.save()
        
    }
    
    
    
    func getTask(_ id: NSManagedObjectID) -> Task? {
        return coreDataManager.get(id)
    }
    
    func getTasks() -> [Task] {
        return coreDataManager.getAll()
    }
    
    
    func getItemFromStorageWithTitle(_ title: String) -> Task? {
        let allCoreDataItems = getTasks()
        for item in allCoreDataItems {
            if item.title == title {
                return item
            }
        }
        return nil
    }
    
    
    
}


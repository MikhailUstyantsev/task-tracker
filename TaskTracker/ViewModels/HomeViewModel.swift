//
//  HomeViewModel.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import Foundation

final class HomeViewModel: NSObject {
    
    let title = "Tasks"
    
    var onUpdate = {}

    enum Cell {
        case task(TaskCellViewModel)
    }
    
    var cells: [Cell] = []

    let taskService: TaskServiceProtocol
    
    init(taskService: TaskServiceProtocol = TaskService()) {
        self.taskService = taskService
    }
    
    func viewDidLoad() {
        reload()
    }
    
    func reload() {
        let tasks = taskService.getTasks()
        
        cells = tasks.map {
            let taskCellViewModel = TaskCellViewModel($0)
            return .task(taskCellViewModel)
        }
        
        onUpdate()
        
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    
}

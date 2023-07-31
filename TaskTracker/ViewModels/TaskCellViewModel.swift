//
//  TaskCellViewModel.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 31.07.2023.
//

import Foundation


struct TaskCellViewModel {
    
    let date = Date()
    
    var task: Task
    
    init(_ task: Task) {
        self.task = task
    }
    
    var dateText: String {
        let eventDate = task.date ?? Date()
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",").joined() ?? ""
    }
    
    var taskName: String? {
        task.title
    }
    
    var isChecked: Bool {
        task.isChecked
    }
    
    
    
}

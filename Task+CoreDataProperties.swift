//
//  Task+CoreDataProperties.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 31.07.2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var isChecked: Bool
    @NSManaged public var title: String?
    @NSManaged public var date: Date?

}

extension Task : Identifiable {

}

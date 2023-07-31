//
//  Coordinator.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import UIKit

typealias CoordinatorHandler = () -> ()

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    var flowCompletionHandler: CoordinatorHandler? { get set }
    func start()
    
}

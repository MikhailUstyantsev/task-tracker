//
//  CoordinatorFactory.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import UIKit

class CoordinatorFactory {
    
    func createAppCoordinator(navigationController: UINavigationController) -> AppCoordinator {
        AppCoordinator(navigationController: navigationController)
    }
    
    func createHomeCoordinator(navigationController: UINavigationController) -> HomeCoordinator {
        HomeCoordinator(navigationController: navigationController)
    }
    
}

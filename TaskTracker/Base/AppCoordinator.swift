//
//  AppCoordinator.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import UIKit

class AppCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    var flowCompletionHandler: CoordinatorHandler?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private var childCoordinators: [Coordinator] = []
    
    func start() {
        showHomeFlow()
    }
    
    private func showHomeFlow() {
        let homeCoordinator = CoordinatorFactory().createHomeCoordinator(navigationController: navigationController)
        childCoordinators.append(homeCoordinator)
        
        homeCoordinator.flowCompletionHandler = { [weak self] in
            //выполняем действие когда завершился флоу координатора - в текущем проекте не используется - оставил для расширения на будущее
            self?.flowCompletionHandler?()
        }
        
        homeCoordinator.start()
    }
    
    
    private func showRegistrationFlow() {
        print("Registration flow initiated")
    }
    
    
}

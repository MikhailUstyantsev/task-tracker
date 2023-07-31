//
//  HomeCoordinator.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    var flowCompletionHandler: CoordinatorHandler?
    
    private let moduleFactory = ModuleFactory()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeModule()
    }
    
    var currentController: HomeViewController?
    
    private func showHomeModule() {
       let controller = moduleFactory.createHomeModule()
        
        controller.completionHandler = { [weak self] in
            self?.currentController = controller
            //MARK: открыли AddTaskViewController
            self?.showAddTaskModule()
        }
        
        navigationController.pushViewController(controller, animated: true)
    }
    
    
    private func showAddTaskModule() {
        let controller = moduleFactory.createEditTaskModule()
        self.modalNavigationController = UINavigationController()
        modalNavigationController?.setViewControllers([controller], animated: false)
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true)
        }
        
        
        controller.completionHandler = { [weak self] in
            //MARK: закрыли AddTaskViewController
            self?.didEndEditTaskModule()
            self?.currentController?.viewModel.viewDidLoad()
        
        }
        
    }
    
    private func didEndEditTaskModule() {
        navigationController.dismiss(animated: true)
    }
    
    
}

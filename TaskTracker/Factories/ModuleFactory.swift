//
//  ModuleFactory.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import Foundation


class ModuleFactory {
    
    func createHomeModule() -> HomeViewController {
        let viewModel = HomeViewModel()
        
        return HomeViewController(viewModel: viewModel)
    }
    
    
    func createEditTaskModule() -> AddTaskViewController {
        let cellBuilder = AddTaskCellBuilder()
        let viewModel = AddTaskViewModel(cellBuilder: cellBuilder)
        
        return AddTaskViewController(viewModel: viewModel)
    }
    
    
}

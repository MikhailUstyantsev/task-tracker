//
//  EditTaskViewModel.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import Foundation

final class AddTaskViewModel: NSObject {
    
    let title = "Добавить"
    var onUpdate: () -> Void = {}
    
    enum Cell {
        case titleSubtitle(TitleSubtitleCellViewModel)
    }
    
    private(set) var cells: [AddTaskViewModel.Cell] = []
    
    
    private var titleCellViewModel: TitleSubtitleCellViewModel?
    private var dateCellViewModel: TitleSubtitleCellViewModel?
    private let cellBuilder: AddTaskCellBuilder
    private let taskService: TaskServiceProtocol
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter
    }()
    
    init(cellBuilder: AddTaskCellBuilder, taskService: TaskServiceProtocol = TaskService()) {
        self.cellBuilder = cellBuilder
        self.taskService = taskService
    }
    
    func viewDidLoad() {
        setupCells()
        onUpdate()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(for indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
                titleSubtitleCellViewModel.update(title)
            
        }
    }
    
    func updateCell(indexPath: IndexPath, subtitle: String) {
        switch cells[indexPath.row] {
        case .titleSubtitle(let titleSubtitleCellViewModel):
            titleSubtitleCellViewModel.update(subtitle)
        }
    }
    
    func tappedDone() {

        guard let name = titleCellViewModel?.subtitle,
              let dateString = dateCellViewModel?.subtitle,
              let date = dateFormatter.date(from: dateString) else { return }
        

        taskService.perform(.add, data: TaskService.TaskInputData(
            name: name,
            date: date,
            isChecked: false))
        
        //далее: dismiss VC - эту работу выполняет completionHandler AddTaskViewController (потому-что конформит FlowController)
    }
    
}


private extension AddTaskViewModel {
    
    func setupCells() {
        titleCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.text)
        
        dateCellViewModel = cellBuilder.makeTitleSubtitleCellViewModel(.date) {
            [weak self] in
            self?.onUpdate()
        }
        
        guard let titleCellViewModel = titleCellViewModel, let dateCellViewModel = dateCellViewModel else { return }
        
        cells = [
            .titleSubtitle(titleCellViewModel),
            .titleSubtitle(dateCellViewModel)
        ]
    }
    
}

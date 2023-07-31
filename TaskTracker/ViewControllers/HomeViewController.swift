//
//  ViewController.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import UIKit

class HomeViewController: UIViewController, FlowController {
    
    var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var completionHandler: (() -> ())?
    
    private let button = UIButton(type: .custom)
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
        viewModel.onUpdate = { [weak self] in
            self?.tableView.reloadData()
        }
        
        setupHierarchy()
        setupLayout()
        
        viewModel.viewDidLoad()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
    
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 80
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskCell.self, forCellReuseIdentifier: "TaskCell")
        
        button.setTitle("Добавить", for: .normal)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.imageEdgeInsets.left = -5
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }

    private func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    private func setupLayout() {
        let margins = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 140),
            button.heightAnchor.constraint(equalToConstant: 50),
            button.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -30),
            button.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -40),
            
            tableView.topAnchor.constraint(equalTo: margins.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
    
    @objc private func addTaskButtonTapped() {
        completionHandler?()
    }
    
}

extension HomeViewController: UITableViewDataSource, CellCheckboxTapDelegate {
    
    func tableCell(didClickedCheckBoxOf tableCell: UITableViewCell) {
        if let rowIndexPath = tableView.indexPath(for: tableCell) {
            //MARK: Save to CoreData updated task
            let task = viewModel.taskService.getTasks()[rowIndexPath.row]
            let name = task.title ?? ""
            let date = task.date ?? Date()
            let isChecked = !task.isChecked
            
            viewModel.taskService.perform(.update(task), data: TaskService.TaskInputData(
                name: name,
                date: date,
                isChecked: isChecked))
           
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.cell(at: indexPath) {
        case .task(let taskCellViewModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else { return UITableViewCell() }
            cell.delegate = self
            cell.update(with: taskCellViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? TaskCell else { return }
//        cell.checkBox.toggle()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = viewModel.taskService.getTasks()[indexPath.row]
           
            //удаление из Core Data
            CoreDataManager.shared.deleteItem(task)
            viewModel.cells.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
    }
    
    
}

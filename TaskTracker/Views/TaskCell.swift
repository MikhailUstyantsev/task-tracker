//
//  TaskCell.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 31.07.2023.
//

import UIKit

protocol CellCheckboxTapDelegate {
    func tableCell(didClickedCheckBoxOf tableCell: UITableViewCell)
}

class TaskCell: UITableViewCell {

    var delegate: CellCheckboxTapDelegate?
    var tapGestureRecognizer = UITapGestureRecognizer()
    
    private let dateLabel = UILabel()
    private let taskNameLabel = UILabel()
    let checkBox = CircularCheckbox()
    private let verticalStackView = UIStackView()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        tapGestureRecognizer.addTarget(self, action: #selector(TaskCell.checkBoxTapped(gestureRecgonizer:)))
                self.addGestureRecognizer(tapGestureRecognizer)
        
        [dateLabel, taskNameLabel, checkBox, verticalStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        dateLabel.font = .systemFont(ofSize: 17, weight: .regular)
        dateLabel.textColor = .label
        
        taskNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        taskNameLabel.textColor = .label
        taskNameLabel.numberOfLines = 0
        taskNameLabel.setContentHuggingPriority(.defaultLow - 1, for: .vertical)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        
      
    
        checkBox.clipsToBounds = true
        checkBox.layer.cornerRadius = 15
    }
     
    private func setupHierarchy() {
        verticalStackView.addArrangedSubview(taskNameLabel)
        verticalStackView.addArrangedSubview(dateLabel)
        
        contentView.addSubview(checkBox)
        contentView.addSubview(verticalStackView)
        
        
        
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            checkBox.widthAnchor.constraint(equalToConstant: 30),
            checkBox.heightAnchor.constraint(equalToConstant: 30),
            checkBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            checkBox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            verticalStackView.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 20),
            verticalStackView.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    
    func update(with viewModel: TaskCellViewModel) {
        checkBox.isChecked = viewModel.isChecked
        checkBox.setBackground()
        dateLabel.text = "Осталось \(viewModel.dateText)"
        taskNameLabel.text = viewModel.taskName
    }
    
    @objc func checkBoxTapped(gestureRecgonizer: UITapGestureRecognizer) {
        delegate?.tableCell(didClickedCheckBoxOf: self)
        checkBox.toggle()
    }
   
    
}

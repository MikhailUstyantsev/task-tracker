//
//  CircularCheckbox.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 31.07.2023.
//

import UIKit

final class CircularCheckbox: UIView {
    
    public var isChecked = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemBlue.cgColor
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        self.isChecked = !isChecked
   
        if self.isChecked {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .systemBackground
        }
    }

    
    func setBackground() {
        if self.isChecked {
            backgroundColor = .systemBlue
        } else {
            backgroundColor = .systemBackground
        }
    }
    
    
}

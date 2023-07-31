//
//  FlowController.swift
//  TaskTracker
//
//  Created by Mikhail Ustyantsev on 29.07.2023.
//

import Foundation

protocol FlowController {
    
    //associatedtype T - можно при желании пробросить в комплишн, чтобы передавать объекты между контроллерами
    
    var completionHandler: (() -> ())? { get set }
    
}

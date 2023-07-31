//
//  Date+Extensions.swift
//  EventCountdownApp - MVVM-C
//
//  Created by Mikhail Ustyantsev on 03.12.2022.
//

import Foundation

extension Date {
    func timeRemaining(until endDate: Date) -> String? {
        let dateComponentsFormatter = DateComponentsFormatter()
        dateComponentsFormatter.allowedUnits = [.year, .month,. weekOfMonth, .day]
        dateComponentsFormatter.unitsStyle = .full
        dateComponentsFormatter.calendar?.locale = Locale(identifier: "ru_RU")
        return dateComponentsFormatter.string(from: self, to: endDate)
    }
}

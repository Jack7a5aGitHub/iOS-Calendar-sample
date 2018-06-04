//
//  Date+prevAndNext.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/01.
//  Copyright © 2018 Jack. All rights reserved.
//

import Foundation

extension Date {
    
    func monthAgeDate() -> Date {
        let addValue = -1
        let calendar = Calendar.current
        var datecomponents = DateComponents()
        datecomponents.month = addValue
        return calendar.date(byAdding: datecomponents, to: self)!
    }
    
    func monthLaterDate() -> Date {
        let addValue = 1
        let calendar = Calendar.current
        var datecomponents = DateComponents()
        datecomponents.month = addValue
        return calendar.date(byAdding: datecomponents, to: self)!
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
    func monthAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("ddd")
        return dateFormatter.string(from: self)
    }
}


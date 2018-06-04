//
//  Model.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/01.
//  Copyright © 2018 Jack. All rights reserved.
//

import Foundation

final class Model {
    
    let DaysPerWeek = 7
    var selectedDate = Date()
    
    func startOfDay(date: Date) -> Date {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: date)
        return today
    }
    
    func currentMonthNumberOfDays(date: Date) -> Int {
        let range = Calendar.current.range(of: .day, in: .month, for: date)
        let numberOfdays = range?.count
        return numberOfdays!
    }
    
    func calculationNumberOfItems() -> Int {
        let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: firstDateOfMonth(date: selectedDate))
        let numberOfWeeks = rangeOfWeeks?.count
        let numberOfItem = numberOfWeeks! * DaysPerWeek
        return numberOfItem
    }
    
    func firstDateOfMonth(date: Date) -> Date {
        let unitFlags = Set<Calendar.Component>([.day,.month,.year])
        var components = Calendar.current.dateComponents(unitFlags, from: date)
        components.day = 1
        let firstDateMonth = Calendar.current.date(from: components)
        return firstDateMonth!
    }
    
    func dateForCellAtIndexPath(date: Date, indexPathItem: Int) -> Date {
        let ordinalityOfFirstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: date)
        var dateComponents = DateComponents()
        dateComponents.day = indexPathItem - (ordinalityOfFirstDay! - 1)
        let date = Calendar.current.date(byAdding: dateComponents, to: date)
        return date!
    }
    func checkTheDateInMonth(date: Date) -> Bool {
        let unitFlags = Set<Calendar.Component>([.day,.month,.year])
        let controlComponents = Calendar.current.dateComponents(unitFlags, from: selectedDate)
        let components = Calendar.current.dateComponents(unitFlags, from: date)
        if controlComponents.month == components.month {
            return true
        }
        return false
    }
    func checkWeekend(date: Date) -> Int {
        //Calendar.current.component able to check current year, month...
        let calendar = Calendar.current
        let weekDayOfDate = calendar.component(.weekday, from: date)
        // show which day today is 
        return weekDayOfDate
    }
}

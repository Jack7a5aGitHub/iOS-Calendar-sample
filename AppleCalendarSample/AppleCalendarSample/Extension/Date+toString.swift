//
//  Date+toString.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/01.
//  Copyright © 2018 Jack. All rights reserved.
//

import Foundation

extension Date {
    
    /// Date型をString型に変更する
    func toStr(dateFormat: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .short
        dateFormatter.dateFormat = dateFormat
        
        return dateFormatter.string(from: self)
    }
}

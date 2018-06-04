//
//  WeekViewController.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class WeekViewController: UIViewController {
    
    //Mark: -Properties
    private var selectedDate: Date!
    
    //MARK: -Factory
    class func make(with date: Date) -> WeekViewController {
        let vcName = WeekViewController.className
        guard let weekVC = UIStoryboard.viewController(storyboardName: vcName, identifier: vcName) as? WeekViewController else {
            
            fatalError("WeekVC is nil")
        }
        weekVC.selectedDate = date
        return weekVC
    }
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        print("In Week VC : \(selectedDate)")
    }
}

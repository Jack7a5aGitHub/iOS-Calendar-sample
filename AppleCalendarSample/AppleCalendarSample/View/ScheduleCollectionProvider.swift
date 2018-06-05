//
//  ScheduleCollectionProvider.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/05.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class ScheduleCollectionProvider: NSObject {
    
    private var dayItems = 0
   
    func set(dayItems : Int) {
        self.dayItems = dayItems
    }
  
}

extension ScheduleCollectionProvider: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scheduleCell", for: indexPath) as? ScheduleCell else {
            fatalError()
        }
        cell.backgroundColor = .red
        
        cell.setupTimeTableView()
        return cell
    }
}

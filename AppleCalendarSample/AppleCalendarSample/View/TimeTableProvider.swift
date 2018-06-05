//
//  TimeTableProvider.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/05.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class TimeTableProvider: NSObject {
    
    private var timeIntervals = [String]()
    
    func set(items: [String]){
        self.timeIntervals = items
    }
}

extension TimeTableProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeIntervals.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as? TimeTableCell else {
            fatalError()
        }
        cell.timeLabel.text = timeIntervals[indexPath.row]
      
        return cell
    }
}

//
//  ScheduleCell.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class ScheduleCell: UICollectionViewCell {
    
    @IBOutlet weak var timeTableView: UITableView!
    private let timeArray = ["0:00","1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    private let timeTableProvider = TimeTableProvider()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// セルの中のCollectionViewを設置する。
    func setupTimeTableView(){
     
        timeTableProvider.set(items: timeArray)
        timeTableView.dataSource = timeTableProvider
        timeTableView.delegate = self
      //verticalCollectionView.contentInset = UIEdgeInsetsMake(65, 0, 0, 0)
        
    }
}
extension ScheduleCell: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped : \(indexPath.row)")
        NotificationCenter.default.post(name: Notification.Name("getDate"), object: nil)
    }
}

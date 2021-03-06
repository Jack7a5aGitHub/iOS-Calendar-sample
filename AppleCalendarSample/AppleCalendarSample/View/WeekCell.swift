//
//  WeekCell.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class WeekCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    var date : Date!
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? .black : .clear
            self.dayLabel.textColor = isSelected ? .white : .black
        }
    }
}

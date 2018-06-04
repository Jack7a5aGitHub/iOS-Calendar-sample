//
//  ScheduleCell.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class ScheduleCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var reserveButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}

//
//  WeekViewController.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/04.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class WeekViewController: UIViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var weekCollectionView: UICollectionView!
    @IBOutlet weak var scheduleTableView: UITableView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //Mark: -Properties
    private var selectedDate: Date!
    private let model = Model()
    private var dayCount = 0
    private let CellMargin = 2.0
    private let timeArray = ["0:00","1:00","2:00","3:00","4:00","5:00","6:00","7:00","8:00","9:00","10:00","11:00","12:00","13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    
    
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
        setupWeekVCModel()
        setupWeekCollectionView()
        setupScheduleTableView()
    }
}

extension WeekViewController {
    private func setupWeekVCModel(){
        model.selectedDate = self.selectedDate
        dayCount = model.calculationNumberOfItems()
        dateLabel.text = self.selectedDate.toStr(dateFormat: "yyyy年M月dd日")
        print("In Week VC : \(selectedDate)")
        print("Model selected Date : \(model.selectedDate)")
        print("Number of Items \(model.calculationNumberOfItems())")
        print("First Date of Month \(model.firstDateOfMonth(date: self.selectedDate))")
    }
    private func setupWeekCollectionView(){
        weekCollectionView.dataSource = self
        weekCollectionView.delegate = self
    }
    private func setupScheduleTableView(){
        scheduleTableView.dataSource = self
        scheduleTableView.delegate = self
    }
}
    //MARK: - UICollectionViewDelegate
extension WeekViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? WeekCell,
              let selectedDay = cell.date else {
                print("eeeefroritgrgrg")
            return
        }
        dateLabel.text = selectedDay.toStr(dateFormat: "yyyy年M月dd日")
        print("Tapped \(selectedDay)")
    }
}
    //MARK: - UICollectionViewDataSource
extension WeekViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dayCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCell", for: indexPath) as? WeekCell else {
            fatalError()
        }
        let date = model.dateForCellAtIndexPath(date: self.selectedDate,indexPathItem: indexPath.row)
        cell.dayLabel.text = date.toStr(dateFormat: "d")
        cell.date = date
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WeekViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfMargin = 8.0
        let width = (collectionView.frame.size.width - CGFloat(CellMargin * numberOfMargin)) / 7
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(CellMargin), CGFloat(CellMargin), CGFloat(CellMargin), CGFloat(CellMargin))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(CellMargin)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(CellMargin)
    }
}

//MARK: - UITableViewDelegate
extension WeekViewController: UITableViewDelegate {
    
}

//MARK: - UITableViewDelegate
extension WeekViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return timeArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as? ScheduleCell else {
            fatalError()
        }
        cell.timeLabel.text = timeArray[indexPath.row]
        return cell
    }
}


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


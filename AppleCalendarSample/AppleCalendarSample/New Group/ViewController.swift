//
//  ViewController.swift
//  AppleCalendarSample
//
//  Created by Jack Wong on 2018/06/01.
//  Copyright © 2018 Jack. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    //MARK: -IBOutlet
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var calendarView: UICollectionView!
    
    //MARk: -Properties
    let model = Model()
    let CellMargin = 2.0
    var dateCount = 0
    
    //MARK; -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupModel()
        setupCalendarCollection()
       
//        print("Number of Items \(model.calculationNumberOfItems())")
//        print("check Weekend \(model.checkWeekend(date: Date()))")
//        print("First Date of Month \(model.firstDateOfMonth())")
//        print("start Date \(model.currentMonthNumberOfDays(date: Date().yesterday))")
//        let yesterday = Date().yesterday
//        print(yesterday.monthAsString())
    }
    
    //MARK: IBAction
    
    @IBAction func previousMonth(_ sender: Any) {
        model.selectedDate = model.selectedDate.monthAgeDate()
        dateCount = model.calculationNumberOfItems()
        dateLabel.text = model.selectedDate.toStr(dateFormat: "yyyy/MM")
        calendarView.reloadData()
    }
    
    @IBAction func nextMonth(_ sender: Any) {
        model.selectedDate = model.selectedDate.monthLaterDate()
        dateCount = model.calculationNumberOfItems()
        dateLabel.text = model.selectedDate.toStr(dateFormat: "yyyy/MM")
        calendarView.reloadData()
    }
    
}
    //MARK: - private func
extension ViewController {
    private func setupCalendarCollection(){
        calendarView.dataSource = self
        calendarView.delegate = self
    }
    private func setupModel() {
        let jpt = Calendar.current.dateComponents(in: TimeZone(identifier: "Asia/Tokyo")!, from: Date())
        print("Japan Time: \(jpt)")
        model.selectedDate = jpt.date!
        dateCount = model.calculationNumberOfItems()
        dateLabel.text = model.selectedDate.toStr(dateFormat: "yyyy/MM")
    }
}

    //MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dateCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? MonthCell else {
            fatalError()
        }
       
        let date = model.dateForCellAtIndexPath(indexPathItem: indexPath.row)
        cell.date = model.dateForCellAtIndexPath(indexPathItem: indexPath.row + 1)
        cell.label.text = date.toStr(dateFormat: "d")
        cell.label.textColor = model.checkTheDateInMonth(date: date) ? .black : .gray
        if (model.checkTheDateInMonth(date: date)) {
            switch model.checkWeekend(date: date) {
            case 1:
                cell.label.textColor = .red
            case 7:
                cell.label.textColor = .blue
            default:
                break
            }
        }
        return cell
    }
}

    //MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MonthCell,
              let selectedDate = cell.date  else {
            return
        }
        
        print(cell.label.text)
        print(selectedDate)
        let weekVC = WeekViewController.make(with: selectedDate)
        self.navigationController?.pushViewController(weekVC, animated: true)
    }
}

    //MARK: - UICollectionViewDelegateFlowLayout
extension ViewController: UICollectionViewDelegateFlowLayout {
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

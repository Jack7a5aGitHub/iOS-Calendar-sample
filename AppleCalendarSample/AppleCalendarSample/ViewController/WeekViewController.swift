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
    @IBOutlet weak var scheduleCollectionView: UICollectionView!
    @IBOutlet weak var dateLabel: UILabel!
    
    //Mark: -Properties
    private var selectedDate: Date!
    private let model = Model()
    private let scheduleCollectionProvider = ScheduleCollectionProvider()
    private var dayCount = 0
    private let CellMargin = 2.0
    private var selectedItem: Int = 0
    {
        willSet {
            print("we will set selected Item \(selectedItem)")
            
        }
        didSet{
            print("did Set selected value \(selectedItem)")
            let selectedIndexPath = IndexPath(item: selectedItem, section: 0)
            weekCollectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: .bottom)
            print("my selectedItem :\(selectedItem)")
        }
    }
    private var onceTime = true
    
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
        setupCollectionView()
        addObserver()
     
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension WeekViewController {
    
    private func setupWeekVCModel(){
        model.selectedDate = self.selectedDate
        dayCount = model.calculationNumberOfItems()
        dateLabel.text = self.selectedDate.toStr(dateFormat: "yyyy年M月dd日")

    }
    private func setupCollectionView(){
        weekCollectionView.dataSource = self
        weekCollectionView.delegate = self
        scheduleCollectionProvider.set(dayItems: dayCount)
        scheduleCollectionView.dataSource = scheduleCollectionProvider
        scheduleCollectionView.delegate = self
    }
    
    private func scrollToWeekIndex(weekIndex: Int) {
        let indexPath = IndexPath(item: weekIndex, section: 0)
        print("Scroll To Index  \(weekIndex)")
        guard let cell = weekCollectionView.cellForItem(at: indexPath) as? WeekCell else { return }
        selectedDate = cell.date
        scheduleCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    /// Horizontal CollectionView Swipeすると上のメニューをリンクする。
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        print("Current Page : \(targetContentOffset.pointee.x / view.frame.width)")
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        weekCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        guard let cell = weekCollectionView.cellForItem(at: indexPath) as? WeekCell
             else {
                return
        }
        selectedDate = cell.date
        dateLabel.text = selectedDate.toStr(dateFormat: "yyyy年M月dd日")
    
    }
    private func addObserver(){
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(getDate), name: Notification.Name("getDate"), object: nil)
    }
    @objc private func getDate(){
        print("The Date: \(selectedDate)")
    }
  
}

    //MARK: -  UICollectionViewDelegate
extension WeekViewController: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case weekCollectionView:
            
            self.scrollToWeekIndex(weekIndex: indexPath.row)
            guard let cell = collectionView.cellForItem(at: indexPath) as? WeekCell,
                let selectedDay = cell.date else {
                    return
            }
            dateLabel.text = selectedDay.toStr(dateFormat: "yyyy年M月dd日")
            print("Tapped \(indexPath.item)")
            if onceTime {
                let indexPath = IndexPath(item: selectedItem, section: 0)
                let selectedCell = collectionView.cellForItem(at: indexPath) as? WeekCell
                selectedCell?.isSelected = false
                onceTime = false
            }
        case scheduleCollectionView:
            print("I am Schedule")
            break
        default:
            break
        }
        
    }
}
    //MARK: - Week UICollectionViewDataSource
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
        if cell.date == selectedDate {
            cell.isSelected = true
            selectedItem = indexPath.item
            print("hihi newSelected ITem: \(self.selectedItem)")
        }
        
        return cell
      
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension WeekViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case weekCollectionView:
            let numberOfMargin = 8.0
            let width = (collectionView.frame.size.width - CGFloat(CellMargin * numberOfMargin)) / 7
            let height = width * 1.5
            return CGSize(width: width, height: height)
        case scheduleCollectionView:
            let width = scheduleCollectionView.bounds.size.width
            let height = scheduleCollectionView.bounds.size.height
            return CGSize(width: width, height: height)
        default:
            break
        }
        return CGSize(width: 0, height: 0)
       
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(CGFloat(CellMargin), CGFloat(CellMargin), CGFloat(CellMargin), CGFloat(CellMargin))
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(CellMargin)
    }
}


//
//  CalendarView.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit
import Foundation

protocol CalendarViewDelegate
{
    func dateSelected(selectedDate:Date)
    func markedDate()->[String]
}

@IBDesignable class CalendarView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet var daysLabel:[UILabel]!
    
    @IBOutlet var dateView: UICollectionView!
    
    var calendar:Calendar = Calendar.current
    var checkDate:Date = Date()
    var startDateForCalendar = Date()
    var activeMonthInCalendar:Int = 0
    var totalWeeksInMonth:Int = 0
    var dateFrame:CGSize = CGSize(width: 40, height: 40)
    var currentDate:Date!
    var currentDateString:String!
    var markedDates:[String]?
    var delegate:CalendarViewDelegate?
    {
        didSet
        {
            markedDates = delegate?.markedDate()
//            print("marked \(markedDates)")
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let currentCalendar = Calendar.current
        calendar = Calendar(identifier:.gregorian)
        calendar.locale = currentCalendar.locale
        calendar.timeZone = currentCalendar.timeZone
        
        let cDate = Date()
        let timezoneIntervalInSeconds:TimeInterval = TimeInterval(Calendar.current.timeZone.secondsFromGMT(for: cDate))
        checkDate = Date(timeIntervalSinceNow:timezoneIntervalInSeconds)
        currentDate = checkDate
        let day = calendar.component(.day, from: currentDate!)
        let month = calendar.component(.month, from: currentDate!)
        let year = calendar.component(.year, from: currentDate!)
        currentDateString = "\(day)-\(month)-\(year)"
        

        let shortweekdaySymbol:[String] = calendar.veryShortWeekdaySymbols
        let daysLabelCount:Int = daysLabel.count
        for i in 0..<daysLabelCount
        {
            daysLabel[i].text = shortweekdaySymbol[i]
        }
        
        updateLayout(cDate: checkDate)
                

        addSwipeGesture()
        
    }
    
    func addSwipeGesture()
    {
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        var monthValue:Int = 0
        
        if (sender.direction == .left) {
            monthValue = 1
        }
        
        if (sender.direction == .right) {
            monthValue = -1
        }
        
        
        updateCalendar(monthValue: monthValue)
    }
    
    func updateCalendar(monthValue:Int)
    {
        checkDate = calendar.date(byAdding: .month, value: monthValue, to: checkDate)!
        updateLayout(cDate: checkDate)
    }
    
    func updateLayout(cDate:Date)
    {
        var dc = DateComponents()
        let day = calendar.component(.day, from: cDate)
        dc.day = (day-1) * -1

        let firstDayOfTheMonth = (calendar.date(byAdding: dc, to: cDate))!
        let weekday = calendar.component(.weekday, from: firstDayOfTheMonth)
        dc.day = (weekday-1) * -1

        startDateForCalendar = (calendar.date(byAdding: dc, to: firstDayOfTheMonth))!
                
        activeMonthInCalendar = calendar.component(.month, from: cDate)
        let cMonthSymbol = calendar.monthSymbols[activeMonthInCalendar-1]
        monthLabel.text = "\(cMonthSymbol)"

        let cYear = calendar.component(.year, from: cDate)
        yearLabel.text = "\(cYear)"
        
        
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: checkDate)
        let days = (calendar.component(.day, from: nextMonth!))
        let lastDateOfTheMonth = calendar.date(byAdding: .day, value: -1 * days, to: nextMonth!)
        totalWeeksInMonth = calendar.component(.weekOfMonth, from: lastDateOfTheMonth!)
        
        
        dateView.reloadData()
    }
    
    
    
    func xibSetup() {
        
        print("xibSetup")
        loadViewFromNib()
        dateView.register(UINib(nibName: "DateCell", bundle: nil), forCellWithReuseIdentifier: "dateCell")
        dateView.delegate = self
        dateView.dataSource = self
        
    }
    func loadViewFromNib(){
        let bundle = Bundle(for: type(of: self))
        let nib = bundle.loadNibNamed("CalendarView", owner: self, options: nil)

        guard let customView = nib?[0] else { return }
        let customUIView = customView as! UIView
        view.frame = customUIView.bounds
        
        addSubview(view)
    }
    
    override init(frame: CGRect) {
        print("init frame")
        super.init(frame: frame)
        xibSetup()
        
    }
    
    // this is called if view used in storyboard
    required init?(coder aDecoder: NSCoder) {
        print("init coder")
        super.init(coder: aDecoder)
        xibSetup()
        
    }
    
    @IBAction func calendarButton(sender:UIButton)
    {
        var monthvalue = 0
        if(sender.tag == 0)
        {
            // prefButton
            monthvalue = -1
        }
        else
        {
            // nextbutton
            monthvalue = 1
        }
        
        updateCalendar(monthValue: monthvalue)
    }

    
}

extension CalendarView:UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    // MARK: Data Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return totalWeeksInMonth
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dateCell", for: indexPath) as! DateCell
        let dateIndex = indexPath.section * collectionView.numberOfItems(inSection: indexPath.section) + indexPath.row
        
        var dc = DateComponents()
        dc.day = dateIndex
        
        let date = calendar.date(byAdding: dc, to: startDateForCalendar)
        let day = calendar.component(.day, from: date!)
        let month = calendar.component(.month, from: date!)
        let year = calendar.component(.year, from: date!)
        let dateString = "\(day)-\(month)-\(year)"

        cell.setup(cellDate:date!, currentActiveMonth: activeMonthInCalendar,calendar: calendar)
        
        if markedDates?.contains(dateString) ?? false
        {
            cell.marked(dateString: dateString)
        }
        cell.today(dateString: currentDateString)
        return cell
    }
    
    // MARK: View Delegate Flow Layout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return dateFrame
    }
        
    
    // MARK: Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("didSelect")
        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
        delegate?.dateSelected(selectedDate: cell.cellDate)
//        cell.selected()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        print("didDeSelect")
//        let cell = collectionView.cellForItem(at: indexPath) as! DateCell
//        cell.deselect()
    }
}

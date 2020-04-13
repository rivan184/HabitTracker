//
//  DateCell.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class DateCell: UICollectionViewCell {

    @IBOutlet weak var bg: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    var cellDate:Date!
    var calendar:Calendar!
    var dateString:String = ""
    var markedColor:UIColor = .white
    var month = 0
    
    var currentActiveMonth:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bg.frame = self.frame
        bg.isUserInteractionEnabled = false
    }
    
    
    
    func setup(cellDate:Date, currentActiveMonth:Int, calendar:Calendar)
    {
        self.cellDate = cellDate
        let day = calendar.component(.day, from: cellDate)
        month = calendar.component(.month, from: cellDate)
        let year = calendar.component(.year, from: cellDate)
        
        dateString = "\(day)-\(month)-\(year)"
        self.currentActiveMonth = currentActiveMonth

        self.layer.cornerRadius = self.frame.width * 0.5
        
        self.dateLabel.text = "\(day)"
        if month == currentActiveMonth
        {
            dateLabel.textColor = .black
            bg.backgroundColor = .white
        }
        else
        {
            dateLabel.textColor = .gray
            bg.backgroundColor = .white
        }
    }
    
    func marked(dateString:String)
    {
        bg.backgroundColor = markedColor
        if(month == currentActiveMonth)
        {
            dateLabel.textColor = .black
        }
        else
        {
            
            dateLabel.textColor = .gray
            bg.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.6010586895, blue: 0.5804060188, alpha: 1)
        }
    }
    
    func today(dateString:String)
    {
        if self.dateString == dateString
        {
            dateLabel.font = UIFont.boldSystemFont(ofSize: 20)
        }
        else
        {
            dateLabel.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
    override var isSelected: Bool
    {
        didSet
        {
            if isSelected
            {
                layer.borderWidth = 2
            }
            else
            {
                layer.borderWidth = 0
            }
        }
    }

}

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
    
    var currentActiveMonth:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.layer.borderWidth = 1
//        print(self.frame)
//        self.layer.cornerRadius = 20
//        bg.frame.size = CGSize(width: 40, height: 40)
//        bg.layer.cornerRadius = 20
        bg.frame = self.frame
        bg.isUserInteractionEnabled = false
    }
    
    
    
    func setup(cellDate:Date, currentActiveMonth:Int, calendar:Calendar)
    {
        self.cellDate = cellDate
        let day = calendar.component(.day, from: cellDate)
        let month = calendar.component(.month, from: cellDate)
        
        self.currentActiveMonth = currentActiveMonth

        self.layer.cornerRadius = self.frame.width * 0.5
        
        self.dateLabel.text = "\(day)"
        if month == currentActiveMonth
        {
            bg.backgroundColor = .orange
        }
        else
        {
            bg.backgroundColor = .white
        }
    }
    
    override var isSelected: Bool
    {
        didSet
        {
//            if isSelected
//            {
            
//                print("\(cellDate!) isSelected \(isSelected)")
//            }
        }
    }

}

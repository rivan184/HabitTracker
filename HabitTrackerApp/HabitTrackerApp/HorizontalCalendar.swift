//
//  HorizontalCalendar.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 12/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class HorizontalCalendar: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
        
    }

}

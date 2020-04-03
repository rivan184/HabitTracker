//
//  DummyData.swift
//  HabitTrackerApp
//
//  Created by Maria Jeffina on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import Foundation
import UIKit

class DummyData: NSObject {
    var name = ""
    var goal = 0
    var color:UIColor = .white
    var tapProgress = 0
        
    init (name: String, goal: Int, color: UIColor, tapProgress: Int) {
        self.name = name
        self.goal = goal
        self.color = color
        self.tapProgress = tapProgress
    }
}

struct HabitData {
    //Data is a collection of habit based on model
    var dataArray = [DummyData]()
}

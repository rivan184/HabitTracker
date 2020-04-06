//
//  Data.swift
//  HabitTrackerApp
//
//  Created by Poppy on 06/04/20.
//  Created by Bernardinus on 04/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import Foundation
import UIKit
struct Data{
    var name : String
    var goal : Int
    var color : UIColor
}
class Habit
{
    var id:String
    var name:String
    
    init(id:String, name:String)
    {
        self.id = id
        self.name = name
    }
}

class Data
{
    let saveDataKey = "habitData"
    var saveData:[String:Any]?
    var habitArr:[Habit] = []
    
    
    init()
    {
        load()
    }
    
    func save()
    {
        
    }
    
    func load()
    {
        saveData =  UserDefaults.standard.dictionary(forKey: saveDataKey)
    }
    
}

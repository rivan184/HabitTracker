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


struct PreDefinedHabit{
    var habitName: String
    var habitDesc: String
    var habitGoal: Int
    var habitColor: PreDefinedColor
}


enum PreDefinedColor:Int
{
    case RED = 0
    case BLUE = 1
    case YELLOW = 2
    case PINK = 3
}

let predefinedColorValue:[PreDefinedColor:UIColor]=[
    PreDefinedColor.RED:#colorLiteral(red: 0.8705882353, green: 0.4156862745, blue: 0.4156862745, alpha: 1),
    PreDefinedColor.BLUE:#colorLiteral(red: 0.06274509804, green: 0.7490196078, blue: 0.9215686275, alpha: 1),
    PreDefinedColor.YELLOW:#colorLiteral(red: 1, green: 0.7843137255, blue: 0.1725490196, alpha: 1),
    PreDefinedColor.PINK:#colorLiteral(red: 0.9294117647, green: 0.3921568627, blue: 0.8588235294, alpha: 1),
]

let predefinedColorValueNotCurrentMonth:[PreDefinedColor:UIColor]=[
    PreDefinedColor.RED:#colorLiteral(red: 0.8901960784, green: 0.6010586895, blue: 0.5804060188, alpha: 1),
    PreDefinedColor.BLUE:#colorLiteral(red: 0.5990196079, green: 0.8570588236, blue: 0.9215686275, alpha: 1),
    PreDefinedColor.YELLOW:#colorLiteral(red: 1, green: 0.9087677725, blue: 0.65, alpha: 1),
    PreDefinedColor.PINK:#colorLiteral(red: 0.9294117647, green: 0.6041176471, blue: 0.8866723916, alpha: 1),
]

let predefinedHabits = [
    PreDefinedHabit(habitName: "Dringking Water",
                    habitDesc: "Hydration is important to your body. Not only it cleanse your digestive system it also refreshes your skin.",
                    habitGoal: 10,
                    habitColor: PreDefinedColor.BLUE),
    
    PreDefinedHabit(habitName: "Take Vitamins",
                    habitDesc: "Making sure your body got enough vitamins can help your health in the long run and strengthen your immune.",
                    habitGoal: 3,
                    habitColor: PreDefinedColor.YELLOW),
    
    PreDefinedHabit(habitName: "Do Exercise",
                    habitDesc: "Exercise helps people lose weight and lower the risk of some diseases.",
                    habitGoal: 1,
                    habitColor: PreDefinedColor.PINK),
    
]

class Habit
{
    var id:String=""
    var name:String
    var goal: Int
    var color: Int
    var currentGoal:[String:Int] = [:]
    
    init()
    {
        self.name = ""
        self.goal = 0
        self.color = PreDefinedColor.RED.rawValue
        self.currentGoal = [:]
    }
    
    init(name:String, goal:Int, color:PreDefinedColor)
    {
        self.name = name
        self.goal = goal
        self.color = color.rawValue
        self.currentGoal = [:]
    }
    
    init(dict:[String:Any])
    {
        self.id = dict["id"] as! String
        self.name = dict["name"] as! String
        self.goal = dict["goal"] as! Int
        self.color = dict["color"] as! Int
        self.currentGoal = dict["currentGoal"] as! [String : Int]
    }
    
    func dictionary() -> [String:Any]
    {
        return [
            "id":self.id,
            "name":self.name,
            "goal":self.goal,
            "color":self.color,
            "currentGoal":self.currentGoal
        ]
    }
    
    
    func update(date:String, value:Int)
    {
        currentGoal[date] = value
        print(currentGoal)
    }
    
    func currentGoalFor(date:String) -> Int
    {
        return currentGoal[date] ?? 0
    }
    
    func description() -> String
    {
        return "id:\(id) name:\(name) goal:\(goal) color:\(color) cGoal:\(currentGoal)"
    }
}


class DataManager
{
    let saveDataKey = "habitData"
    let habitListKey = "habitList"
    
    var saveData:[String:Any] = [:]
    var habitArr:[Habit] = []
    var habitList:[String] = []
    var nextID:Int = 0
    
    
    func TestData()
    {
        var data = Habit(name: "Habit1", goal: 5, color: PreDefinedColor.RED)
        data.update(date: "8-4-2020", value: 2)
        addNewHabit(newHabit: data)
        
        data = Habit(name: "Habit2", goal: 3, color: PreDefinedColor.BLUE)
        data.update(date: "8-4-2020", value: 3)
        data.update(date: "7-4-2020", value: 1)
        addNewHabit(newHabit: data)
        
        data = Habit(name: "Habit3", goal: 4, color: PreDefinedColor.YELLOW)
        addNewHabit(newHabit: data)
    }
    
    init()
    {
//        uncomment this 2 line and run once, to delete all save data
//        UserDefaults.standard.removeObject(forKey: saveDataKey)
//        UserDefaults.standard.synchronize()
        
// uncomment 2 lines below to use template data
//        TestData()
//        save()
        load()
    }
    
    func addNewHabit(newHabit:Habit)
    {
        newHabit.id = "\(nextID)"
        habitArr.append(newHabit)
        print("id \(habitArr[nextID].id) \(nextID)")
        print(habitArr.count)
        nextID += 1
        
    }
    
    func deleteHabit(habit:Habit)
    {
        var habitIndex:Int = 0
        for i in habitArr
        {
            if i.id == habit.id
            {
                habitIndex = habitArr.firstIndex(where: {$0 === i})!
                break
            }
            
        }
        habitArr.remove(at: habitIndex)
        save()
    }

    
    func updateHabit(habit:Habit)
    {
        
        var habitIndex:Int = 0
        for i in habitArr
        {
            if i.id == habit.id
            {
                habitIndex = habitArr.firstIndex(where: {$0 === i})!
                break
            }
            
        }
        habitArr[habitIndex] = habit
        saveData[habit.id] = habit.dictionary()
        
    }
    
    func save()
    {
        habitList.removeAll()
        for i in 0..<habitArr.count
        {
            let cHabit = habitArr[i]
            
            saveData[cHabit.id] = cHabit.dictionary()
            habitList.append(cHabit.id)
        }
                 
        UserDefaults.standard.set(saveData, forKey: saveDataKey)
        UserDefaults.standard.set(habitList, forKey: habitListKey)
        UserDefaults.standard.synchronize()
    }
    
    func load()
    {
        if let data = UserDefaults.standard.dictionary(forKey: saveDataKey)
        {
            saveData =  data
        }
        
        if(saveData.count > 0)
        {
            habitList.removeAll()
            if let dataList = UserDefaults.standard.array(forKey: habitListKey)
            {
                habitList = dataList as! [String]
            }
            
            habitArr.removeAll()
            for habit in habitList
            {
                let habitData = saveData[habit]
                print(habitData!)
                habitArr.append(Habit(dict: habitData as! [String : Any]))
            }
        }
        
    }
    
    
    
}



//
//  HabitDataVC.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 08/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class HabitDataVC: UIViewController {

    @IBOutlet weak var calendarView: CalendarView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var habitGoalLabel: UILabel!
    @IBOutlet weak var habitColor: UIView!
    
//    @IBOutlet weak var goalField: UITextField!
//    @IBOutlet weak var goalStepper: UIStepper!
//    @IBOutlet weak var habitField: UITextField!
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var currentGoalForDate: UILabel!
    @IBOutlet weak var currentGoalLabel: UILabel!
    @IBOutlet var boxContainer:[UIView]!
    
    var habitData:Habit = Habit()
    var selectedColor:UIButton?
    var rootVC:TabBarViewController?
    
//    @IBOutlet var colorPickers:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 10
        
        habitColor.layer.cornerRadius = habitColor.frame.size.width * 0.5
        
//        for picker in colorPickers
//        {
//            picker.layer.cornerRadius = 25
//            picker.backgroundColor = predefinedColorValue[PreDefinedColor(rawValue:picker.tag)!]
//        }
//
//        //stepper action
//        goalStepper.wraps = true
//        goalStepper.autorepeat = true
//        goalStepper.minimumValue = 0
//        goalStepper.maximumValue = 999
//
//
//        goalField.keyboardType = .numberPad
        for i in boxContainer
        {
            i.layer.cornerRadius = 10
        }
        setupValue()
        calendarView.delegate = self
        //dismiss keyboard when touch the screen
        self.dismissKey()

    }
    
    func fillPredefinedData(defaultData:Habit?,rootVC:TabBarViewController)
    {
        self.rootVC = rootVC
        habitData = Habit(name: "", goal: 0, color: .RED)
//        print(habitData.description())
//        print("fill \(defaultData?.description())")
        if defaultData != nil
        {
            habitData.id = defaultData!.id
            habitData.name = defaultData!.name
//            print("\(habitData.name) \(defaultData!.name)")
            habitData.goal = defaultData!.goal
            habitData.color = defaultData!.color
            habitData.currentGoal = defaultData!.currentGoal
        }
//        print(habitData)
        
    }
    
    func setupValue()
    {
        habitName.text = habitData.name
        
        updateCurrentGoalForDate(date:calendarView.currentDate)
                
        habitGoalLabel.text = "\(habitData.goal)x"
        habitColor.backgroundColor = predefinedColorValue[PreDefinedColor(rawValue: habitData.color)!]
        calendarView.refresh()
        
    }
    
    func updateCurrentGoalForDate(date:Date)
    {
        let calendar = calendarView.calendar
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        let checkDate = "\(day)-\(month)-\(year)"
        currentGoalForDate.text = "\(habitData.currentGoalFor(date: checkDate))"
    }
    
    
    @IBAction func editTapped(_ sender: Any) {
        performSegue(withIdentifier: "editView", sender: nil)
        /*
//        print("saveTapped")
        rootVC?.saveDataManager.updateHabit(habit: habitData)
        rootVC?.selectedIndex = 0
        let homeVC = rootVC?.availableViewControllers[0] as! HomeViewController
        homeVC.updateView()
        rootVC?.saveDataManager.save()
        dismiss(animated: true)
 */
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dest = segue.destination as! EditHabitVC
        dest.rootVC = rootVC
        dest.habitData = habitData
        dest.habitDataVC = self
    }
    
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true)
    }
    
}


extension HabitDataVC :CalendarViewDelegate
{
    func dateSelected(selectedDate: Date) {
        updateCurrentGoalForDate(date: selectedDate)
    }
    
    func markedDate() -> [String] {
        return habitData.currentGoal.keys.sorted()
    }
    
    func markedColor() -> UIColor {
        return predefinedColorValue[PreDefinedColor(rawValue:habitData.color)!]!
    }
}

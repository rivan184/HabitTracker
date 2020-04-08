
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
    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var goalStepper: UIStepper!
    @IBOutlet weak var habitField: UITextField!
    @IBOutlet weak var habitName: UILabel!
    @IBOutlet weak var currentGoalForDate: UILabel!
    @IBOutlet weak var currentGoalLabel: UILabel!
    
    var habitData:Habit = Habit()
    var selectedColor:UIButton?
    var rootVC:TabBarViewController?
    
    @IBOutlet var colorPickers:[UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.layer.cornerRadius = 10
        
        for picker in colorPickers
        {
            picker.layer.cornerRadius = 25
            picker.backgroundColor = predefinedColorValue[PreDefinedColor(rawValue:picker.tag)!]
        }
        
        //stepper action
        goalStepper.wraps = true
        goalStepper.autorepeat = true
        goalStepper.minimumValue = 0
        goalStepper.maximumValue = 999
        
        
        goalField.keyboardType = .numberPad
        
        setupValue()
        calendarView.delegate = self
        //dismiss keyboard when touch the screen
        self.dismissKey()

    }
    
    func fillPredefinedData(defaultData:Habit?,rootVC:TabBarViewController)
    {
        self.rootVC = rootVC
        habitData = Habit(name: "", goal: 0, color: .RED)
        print(habitData.description())
        print("fill \(defaultData?.description())")
        if defaultData != nil
        {
            habitData.id = defaultData!.id
            habitData.name = defaultData!.name
            print("\(habitData.name) \(defaultData!.name)")
            habitData.goal = defaultData!.goal
            habitData.color = defaultData!.color
            habitData.currentGoal = defaultData!.currentGoal
        }
        print(habitData)
        
    }
    
    func setupValue()
    {
        habitName.text = habitData.name
        habitField.text = habitData.name
        
        updateCurrentGoalForDate(date:calendarView.currentDate)
        
        goalField.text = "\(habitData.goal)"
        goalStepper.value = Double(habitData.goal)
        
        selectColor(selectionIndex: habitData.color)
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
    
    func selectColor(selectionIndex:Int)
    {
        if selectedColor != nil
        {
            selectedColor?.layer.borderWidth = 0
        }
        selectedColor = colorPickers[selectionIndex]
        selectedColor!.layer.borderWidth = 3

    }
    
    @IBAction func colorTapped(_ sender: UIButton) {
        habitData.color = sender.tag
        selectColor(selectionIndex: habitData.color)
    }
    
    @IBAction func habitFilled(_ sender: Any) {
        if let field = habitField.text
        {
            habitData.name = field
            habitName.text = field
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        habitData.goal = Int(sender.value)
        goalField.text = habitData.goal.description
    }
    
    @IBAction func goalFieldChanged(_ sender: Any) {
        if let field = goalField.text
        {
            habitData.goal = Int(field) ?? 0
            goalStepper.value = Double(habitData.goal)
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        print("saveTapped")
        rootVC?.saveDataManager.updateHabit(habit: habitData)
        rootVC?.selectedIndex = 0
        let homeVC = rootVC?.availableViewControllers[0] as! HomeViewController
        homeVC.updateView()
        rootVC?.saveDataManager.save()
        dismiss(animated: true)
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
}

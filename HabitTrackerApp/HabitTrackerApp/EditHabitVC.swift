//
//  EditHabitVC.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 09/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class EditHabitVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()

        // Do any additional setup after loading the view.
    }
    
    var habitDataVC:HabitDataVC?
    var habitData:Habit = Habit()
    var selectedColor:UIButton?
    var rootVC:TabBarViewController?
    
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var goalStepper: UIStepper!
    @IBOutlet weak var habitField: UITextField!
    @IBOutlet var colorPickers:[UIButton]!
    @IBOutlet weak var saveBtn: UIButton!
    
    var oldHabitName = ""
    var oldHabitGoal = 0
    
    @IBAction func closeModal(_ sender: Any) {
        if habitData.name != oldHabitName || habitData.goal != oldHabitGoal
        {
            showAlertView(view: self, title: "Are you sure?", message: "You will lose all the data.", actionButtonText: "Yes", actionFunction: #selector(dismissModal),cancelButtonText: "No")
        }
        else
        {
            dismissModal()
        }
    }
    
    @objc func dismissModal()
    {
       dismiss(animated: true)
    }
    
    
    func initialize() {
        saveBtn.layer.cornerRadius = 10
        
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
        
        //dismiss keyboard when touch the screen
        self.dismissKey()
    }
    
    func fillPredefinedData(predefinedHabit:PreDefinedHabit?,rootVC:TabBarViewController)
    {
        self.rootVC = rootVC
        habitData = Habit(name: "", goal: 0, color: .RED)
        print(habitData)
        if predefinedHabit != nil
        {
            habitData.name = predefinedHabit!.habitName
            print("\(habitData.name) \(predefinedHabit!.habitName)")
            habitData.goal = predefinedHabit!.habitGoal
            habitData.color = predefinedHabit!.habitColor.rawValue
        }
        print(habitData)
        
    }
    
    func setupValue()
    {
        habitField.text = habitData.name
        
        goalField.text = "\(habitData.goal)"
        goalStepper.value = Double(habitData.goal)
        
        selectColor(selectionIndex: habitData.color)
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

        habitDataVC?.setupValue()
        
        rootVC?.saveDataManager.updateHabit(habit: habitData)
        rootVC?.saveDataManager.save()
        let homeVC = rootVC?.availableViewControllers[0] as! HomeViewController
        homeVC.updateView()
        dismiss(animated: true)
    }
    
    


}

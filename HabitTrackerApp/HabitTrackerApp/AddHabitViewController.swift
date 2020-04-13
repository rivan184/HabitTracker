//
//  AddHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Poppy on 02/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        // Do any additional setup after loading the view.
    }
    
    var habitData:Habit = Habit()
    var selectedColor:UIButton?
    var rootVC:TabBarViewController?
    
    var counter : Int?
    
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var goalStepper: UIStepper!
    @IBOutlet weak var habitField: UITextField!
    @IBOutlet var colorPickers:[UIButton]!
    @IBOutlet weak var colorPicker1: UIButton!
    @IBOutlet weak var colorPicker2: UIButton!
    @IBOutlet weak var colorPicker3: UIButton!
    @IBOutlet weak var colorPicker4: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    var predefineHabitName:String?
    var predefineHabitGoalCount:Int?
    
    @IBAction func closeModal(_ sender: Any) {
        var showAlert = false
        if( predefineHabitName != nil )
        {
            if(habitData.name != predefineHabitName ||  habitData.goal != predefineHabitGoalCount)
            {
                showAlert = true
            }
        }
        else
        {
            if(habitData.name.count > 0 || habitData.goal > 0)
            {
                 showAlert = true
            }
        }
        
        
        if (showAlert)
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
        print("Initialize")
        
        saveBtn.layer.cornerRadius = 10
        /*
        colorPicker1.layer.cornerRadius = 25
        colorPicker2.layer.cornerRadius = 25
        colorPicker3.layer.cornerRadius = 25
        colorPicker4.layer.cornerRadius = 25
        
        colorPicker1.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        colorPicker2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.7490196078, blue: 0.9215686275, alpha: 1)
        colorPicker3.backgroundColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0.1725490196, alpha: 1)
        colorPicker4.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.3921568627, blue: 0.8588235294, alpha: 1)
 */
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
        //save button
        saveBtn.isEnabled = false
        checkSaveButton()
    }
    
    func checkSaveButton()
    {
        saveBtn.backgroundColor = .gray
        if habitData.name.count > 0 && habitData.goal > 0
        {
            saveBtn.isEnabled = true
            saveBtn.backgroundColor = #colorLiteral(red: 0.8888156414, green: 0.2865197659, blue: 0.2528704703, alpha: 1)            
        }
    }
    
    func fillPredefinedData(predefinedHabit:PreDefinedHabit?,rootVC:TabBarViewController)
    {
        self.rootVC = rootVC
        habitData = Habit(name: "", goal: 0, color: .RED)
//        print(habitData)
        counter = 0
        predefineHabitGoalCount = nil
        predefineHabitName = nil
        if predefinedHabit != nil
        {
            counter = 2
            habitData.name = predefinedHabit!.habitName
//            print("\(habitData.name) \(predefinedHabit!.habitName)")
            habitData.goal = predefinedHabit!.habitGoal
            habitData.color = predefinedHabit!.habitColor.rawValue
            predefineHabitGoalCount = habitData.goal
            predefineHabitName = habitData.name
        }
//        print(habitData)
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
        /*
        if sender == colorPicker1 {
            color = colorPicker1.backgroundColor!
        } else if sender == colorPicker2 {
            color = colorPicker2.backgroundColor!
        } else if sender == colorPicker3{
            color = colorPicker3.backgroundColor!
        } else if sender == colorPicker4{
            color = colorPicker4.backgroundColor!
        }
        */
        
    }
    
    @IBAction func habitFilled(_ sender: Any) {
        if let field = habitField.text
        {
            habitData.name = field
            if habitData.name.count > 0
            {
                counter! += 1
            }
            else
            {
                counter! -= 1
                if(counter! < 0)
                {
                    counter = 0
                }
                
            }
            
            checkSaveButton()
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        habitData.goal = Int(sender.value)
        goalField.text = habitData.goal.description
        checkSaveButton()
    }
    
    @IBAction func goalFieldChanged(_ sender: Any) {
        if let field = goalField.text
        {
            habitData.goal = Int(field) ?? 0
            goalStepper.value = Double(habitData.goal)
//            if habitData.goal >= 0
//            {
//                counter! += 1
//            }
//            else
//            {
//                counter! -= 1
//                if(counter! < 0)
//                {
//                    counter = 0
//                }
//            }
            
            checkSaveButton()
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        print("saveTapped")

        rootVC?.saveDataManager.addNewHabit(newHabit: habitData)
        rootVC?.selectedIndex = 0
        let homeVC = rootVC?.availableViewControllers[0] as! HomeViewController
        homeVC.updateView()
        rootVC?.saveDataManager.save()
       
        dismiss(animated: true)
  
    }
    
    
    
}

extension UIViewController {
    
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false; view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissKeyboard(){
        print("dismissKeyboard")
        view.endEditing(true)
    }
}

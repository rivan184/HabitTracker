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
    
    var data : Data?
    
    var goal = ""
    var name = ""
    var color = #colorLiteral(red: 0.8705882353, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
    

    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var goalField: UITextField!
    @IBOutlet weak var goalStepper: UIStepper!
    @IBOutlet weak var habitField: UITextField!
    @IBOutlet weak var colorPicker1: UIButton!
    @IBOutlet weak var colorPicker2: UIButton!
    @IBOutlet weak var colorPicker3: UIButton!
    @IBOutlet weak var colorPicker4: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBAction func closeModal(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func initialize() {
        saveBtn.layer.cornerRadius = 10
        colorPicker1.layer.cornerRadius = 25
        colorPicker2.layer.cornerRadius = 25
        colorPicker3.layer.cornerRadius = 25
        colorPicker4.layer.cornerRadius = 25
        
        colorPicker1.backgroundColor = #colorLiteral(red: 0.8705882353, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        colorPicker2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.7490196078, blue: 0.9215686275, alpha: 1)
        colorPicker3.backgroundColor = #colorLiteral(red: 1, green: 0.7843137255, blue: 0.1725490196, alpha: 1)
        colorPicker4.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.3921568627, blue: 0.8588235294, alpha: 1)
        
        goal = ""
        name = ""
        color = #colorLiteral(red: 0.8705882353, green: 0.4156862745, blue: 0.4156862745, alpha: 1)
        
        //stepper action
        goalStepper.wraps = true
        goalStepper.autorepeat = true
        goalStepper.minimumValue = 0
        
        //dismiss keyboard when touch the screen
        self.dismissKey()
    }
    
    @IBAction func colorTapped(_ sender: UIButton) {
        if sender == colorPicker1 {
            color = colorPicker1.backgroundColor!
        } else if sender == colorPicker2 {
            color = colorPicker2.backgroundColor!
        } else if sender == colorPicker3{
            color = colorPicker3.backgroundColor!
        } else if sender == colorPicker4{
            color = colorPicker4.backgroundColor!
        }
    }
    
    @IBAction func habitFilled(_ sender: Any) {
        if let field = habitField.text{
            name = field
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        goal = Int(sender.value).description
        goalField.text = goal
    }
    
    @IBAction func goalFieldChanged(_ sender: Any) {
        if let field = goalField.text{
            goal = field
            goalStepper.value = Double(goal) ?? goalStepper.value
        }
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        data = Data(name: name, goal: Int(goal) ?? 0, color: color)
        dismiss(animated: true)
    }
    
}

extension UIViewController {
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
            tap.cancelsTouchesInView = false; view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

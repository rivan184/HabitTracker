//
//  NewHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Rivan on 02/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class NewHabitViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{
    struct Habit{
        var habitName: String
        var habitDesc: String
        var habitGoal: Int
        var habitColor: UIColor
    }
    
    let habits = [
        Habit(habitName: "Wash Hands", habitDesc: "Washing hand desc", habitGoal: 10, habitColor: UIColor(red: 88/255, green: 188/255, blue: 230/255, alpha: 1)),
        Habit(habitName: "Take Vitamins",habitDesc: "Take Vitamins desc", habitGoal: 3, habitColor: UIColor(red: 229/255, green: 148/255, blue: 56/255, alpha: 1)),
        Habit(habitName: "Do Exercise", habitDesc: "Do Exercise desc", habitGoal: 1, habitColor: UIColor(red: 221/255, green: 108/255, blue: 211/255, alpha: 1)),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        let habit = habits[indexPath.row]
        
        cell.cellView.layer.cornerRadius = 20
        
        cell.habitNameLabel.text = habit.habitName
        cell.habitDescLabel.text = habit.habitDesc
        cell.habitGoalLabel.text = "\(habit.habitGoal)"
        cell.cellView.backgroundColor = habit.habitColor
        
        return cell
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHabitBtn.layer.cornerRadius = 20
        
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var addHabitBtn: UIButton!
    @IBAction func addNewHabit(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddHabit", sender: nil)
    }

}

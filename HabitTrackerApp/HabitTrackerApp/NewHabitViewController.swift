//
//  NewHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Rivan on 02/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class NewHabitViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addHabitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addHabitBtn.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 250
    }

    
    @IBAction func addNewHabit(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddHabit", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predefinedHabits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell") as! CustomTableViewCell
        cell.selectionStyle = .none
        let habit = predefinedHabits[indexPath.row]
        
        cell.layer.cornerRadius = 10
        cell.cellView.layer.cornerRadius = 10
        
        cell.habitNameLabel.text = habit.habitName
        cell.habitDescLabel.text = habit.habitDesc
        cell.habitGoalLabel.text = "Goal: \(habit.habitGoal)x"
        cell.cellView.backgroundColor = predefinedColorValue[habit.habitColor]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toAddHabit", sender: predefinedHabits[indexPath.row])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var predefinedHabit:PreDefinedHabit? = nil
        if sender != nil
        {
            predefinedHabit = sender as? PreDefinedHabit
        }
        
        
        let addHabitVC = segue.destination as? AddHabitViewController
        let rootVC = tabBarController as! TabBarViewController
        addHabitVC?.fillPredefinedData(predefinedHabit: predefinedHabit,rootVC:rootVC)
        
    }
}



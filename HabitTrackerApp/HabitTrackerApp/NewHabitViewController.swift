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
    
    var selectedCellPath:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "PreDefinedHabitTC", bundle: nil), forCellReuseIdentifier: "customCell")
        
        self.addHabitBtn.layer.cornerRadius = 10
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        setupPanGesture()
        setupTapGesture()
    }
    

    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        print("should")
        selectedCellPath = indexPath
         let cell = tableView.cellForRow(at: indexPath)
         cell?.isHighlighted = true
        
        return true
    }
    @IBAction func addNewHabit(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddHabit", sender: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return predefinedHabits.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
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
        print("didSelect")
        selectedCellPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isHighlighted = true
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if selectedCellPath != nil
        {
            let cell = tableView.cellForRow(at: selectedCellPath!) as! CustomTableViewCell
            cell.isHighlighted = false
        }
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

extension NewHabitViewController :UIGestureRecognizerDelegate{
    func setupPanGesture()
    {
        let panGestureRecog = UIPanGestureRecognizer(target: self, action: #selector(self.panGesture(_:)))
        panGestureRecog.maximumNumberOfTouches = 1
        panGestureRecog.delegate = self
        self.view.addGestureRecognizer(panGestureRecog)
    }
    
    func setupTapGesture()
    {
        let tapGestureRecog = UITapGestureRecognizer(target: self, action: #selector(self.setupTapGesture(_:)))
        tapGestureRecog.numberOfTapsRequired = 1
        tapGestureRecog.delegate = self
        self.view.addGestureRecognizer(tapGestureRecog)
    }
    
    @objc func setupTapGesture(_ tapGestureRecog:UITapGestureRecognizer)
    {
        print("tap gesture")
        let touchPoint = tapGestureRecog.location(in: self.tableView)
        if let indexPath = tableView.indexPathForRow(at: touchPoint)
        {
            //Access the Habit detail view based on indexPath
            //Segue to habitDetailView
            if selectedCellPath != nil
            {
                let cell = tableView.cellForRow(at: indexPath) as! CustomTableViewCell
                cell.isHighlighted = false
//                selectedCellPath = indexPath
            }
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toAddHabit", sender: predefinedHabits[indexPath.row])
            }
        }
    }
    
    @objc func panGesture(_ panGestureRecog:UIPanGestureRecognizer)
    {
        print("panGesture")
        if selectedCellPath != nil
        {
            let cell = tableView.cellForRow(at: selectedCellPath!)
            cell?.isHighlighted = false
            selectedCellPath = nil
        }
        
        
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}



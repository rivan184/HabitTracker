//
//  ViewController.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 31/03/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var habitList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imageViewSetting()
        setupCell()
        setupData()
        setupLongPressGesture()
    }
    
    //MARK: Image Function
    func imageViewSetting(){
        infoImage.layer.cornerRadius = 10
        
        //Tap Image interaction
        infoImage.isUserInteractionEnabled = true
        infoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))
        
    }
    
    @objc func imageTap(){
        //To Present Modally
        self.performSegue(withIdentifier: "viewInfo", sender: infoImage)
    }
    
    func setupCell(){
        habitList.register(UINib(nibName: "HabitTableViewCell", bundle: nil), forCellReuseIdentifier: "habitCell")
    }
    
    // MARK: Appending Dummy Data
    // (Delete if not used)
    var habitModel = [DummyData]()
    
    func setupData(){
        habitModel.append(DummyData(name: "Habit1", goal: 5, color: .cyan, tapProgress: 2))
        habitModel.append(DummyData(name: "Habit2", goal: 3, color: .systemPink, tapProgress: 3))
        habitModel.append(DummyData(name: "Habit3", goal: 4, color: .yellow, tapProgress: 0))
    }


}

//MARK: TableView Delegate & Data Source
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habitModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as! HabitTableViewCell
        cell.model = habitModel[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tapped index: ", indexPath.row)
        let ratio = Float(habitModel[indexPath.row].tapProgress) / Float(habitModel[indexPath.row].goal)
        //If a habit hasnt's been completed, otherwise do nothing
        if ratio < 1 {
            //Increment habit progress
            habitModel[indexPath.row].tapProgress += 1
        }
        //Updating tableView
        tableView.reloadData()
    }
}

//MARK: Handle Long Tap Gesture
extension HomeViewController {
    func setupLongPressGesture(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPres(_:)))
        //Long Press Duration in seconds
        longPressRecognizer.minimumPressDuration = 1.0
        self.view.addGestureRecognizer(longPressRecognizer)
    }

    @objc func handleLongPres(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.habitList)
            if let indexPath = habitList.indexPathForRow(at: touchPoint){
                //Access the Habit detail view based on indexPath
                //Segue to habitDetailView
                self.performSegue(withIdentifier: "showHabitDetail", sender: nil)
                
            }
        }
    }
}


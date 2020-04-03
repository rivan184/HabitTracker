//
//  NewHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Rivan on 02/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class NewHabitViewController: UIViewController {
    
    
    @IBOutlet weak var addHabitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.addHabitButton.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addHabitAction(_ sender: UIButton) {
    }
    
}

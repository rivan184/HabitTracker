//
//  NewHabitViewController.swift
//  HabitTrackerApp
//
//  Created by Poppy on 02/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class NewHabitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBOutlet weak var addHabitBtn: UIButton!
    @IBAction func addNewHabit(_ sender: Any) {
        self.performSegue(withIdentifier: "toAddHabit", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

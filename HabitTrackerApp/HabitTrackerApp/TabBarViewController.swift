//
//  HabitDataViewController.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 07/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    var availableViewControllers:[UIViewController] = []
    var saveDataManager:DataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        saveDataManager.load()
        
        availableViewControllers = self.viewControllers!
        
        
        let homeViewController = availableViewControllers[0] as? HomeViewController
        homeViewController!.prepareData(dataManager: saveDataManager)
        
//        let addHabitViewController = availableViewControllers[1] as? AddHabitViewController
        
    }
}

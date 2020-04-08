//
//  EmergencyCallController.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 07/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class EmergencyCallController: UIViewController {

    @IBOutlet weak var callNowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        callNowButton.layer.borderWidth = 5
        callNowButton.layer.borderColor = #colorLiteral(red: 0.8888156414, green: 0.2865197659, blue: 0.2528704703, alpha: 1)
        callNowButton.layer.cornerRadius = callNowButton.frame.height * 0.5
        
    }
    
    @IBAction func callNowButtonPressed()
    {
        if let url:URL = URL(string: "tel://\(119)"), UIApplication.shared.canOpenURL(url)
        {
            UIApplication.shared.open(url)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func getData()
    {
        print("Emergency View GetData")
    }

}

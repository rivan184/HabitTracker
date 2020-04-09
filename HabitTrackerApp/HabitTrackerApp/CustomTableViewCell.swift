//
//  CustomTableViewCell.swift
//  HabitTrackerApp
//
//  Created by Rivan on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var habitNameLabel: UILabel!
    @IBOutlet weak var habitDescLabel: UILabel!
    @IBOutlet weak var habitGoalLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        frame = CGRect(origin: frame.origin, size: CGSize(width: frame.size.width, height: 250))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

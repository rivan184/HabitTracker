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
    @IBOutlet weak var goalFrame: UIView!
    @IBOutlet weak var selectedView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        goalFrame.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override var isHighlighted: Bool
    {
        didSet
        {
            if isHighlighted
            {
                selectedView.isHidden = false
            }
            else
            {
                selectedView.isHidden = true
            }
        }
    }
}

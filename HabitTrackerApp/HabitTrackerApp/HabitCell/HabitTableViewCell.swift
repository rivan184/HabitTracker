//
//  HabitTableViewCell.swift
//  HabitTrackerApp
//
//  Created by Maria Jeffina on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class HabitTableViewCell: UITableViewCell {
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var habitTitle: UILabel!
    @IBOutlet weak var habitGoal: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    var maxWidth = 358
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Model, Dummy Data
    // Delete if not used
    var model: DummyData? {
        didSet{
            cellConfig()
        }
    }
    
    func cellConfig(){
        guard let habit = model else { return }
        habitTitle.text = habit.name
        habitGoal.text = String(habit.tapProgress)
        
        progressView.layer.cornerRadius = 10
        progressView.layer.backgroundColor = habit.color.cgColor
        widthConstraint.constant = CGFloat(Float(habit.tapProgress)/Float(habit.goal) * Float(self.maxWidth))
        
        progressView.updateConstraints()
    }
    
}

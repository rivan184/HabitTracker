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
    @IBOutlet weak var backgroundProgress: UIView!
    @IBOutlet weak var selectedView: UIView!
    
    @IBOutlet weak var holdToEditLabel: UILabel!
    var maxWidth = 358
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // disable cell highlight
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: Model, Dummy Data
    // Delete if not used
    var model: Habit?
    
    var date:String?
    {
        didSet
        {
            cellConfig(date: date ?? "")
        }
    }
    
    func cellConfig(date:String){
        guard let habit = model else { return }
        habitTitle.text = habit.name
        let progress:Int = habit.currentGoalFor(date: date)
        habitGoal.text = String(progress)
        
        backgroundProgress.layer.cornerRadius = 10
        progressView.layer.cornerRadius = 10
        
        selectedView.frame = backgroundProgress.frame
        selectedView.layer.cornerRadius = 10
        
        let color:PreDefinedColor = PreDefinedColor(rawValue: habit.color)!
        progressView.layer.backgroundColor = predefinedColorValue[color]?.cgColor
        widthConstraint.constant = CGFloat(Float(progress)/Float(habit.goal) * Float(self.maxWidth))
        
        progressView.updateConstraints()
    }
    
    override var isHighlighted: Bool
    {
        didSet
        {
            if isHighlighted
            {
                selectedView.isHidden = false
                holdToEditLabel.isHidden = false
            }
            else
            {
                selectedView.isHidden = true
                holdToEditLabel.isHidden = true
            }
        }
    }
    
}

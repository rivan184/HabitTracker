//
//  AlertViewUtils.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 07/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import Foundation
import UIKit

func showAlertView(view:UIViewController, title:String, message:String)
{
    let alertView = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .cancel)
    alertView.addAction(cancelAction)
    
    let callAction = UIAlertAction(title: "Call",
                                    style: .default,
                                    handler: { (action:UIAlertAction) in
                                        
                                            
                                             }
                                    )
    
    alertView.addAction(callAction)
                                    
    view.present(alertView, animated: true, completion: nil)
    
}

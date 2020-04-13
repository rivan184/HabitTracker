//
//  AlertViewUtils.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 07/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import Foundation
import UIKit

func showAlertView(view:UIViewController, title:String, message:String, actionButtonText:String, actionFunction:Selector, cancelButtonText:String)
{
    let alertView = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
    
    let cancelAction = UIAlertAction(title: cancelButtonText,
                                     style: .cancel)
    alertView.addAction(cancelAction)
    
    let callAction = UIAlertAction(title: actionButtonText,
                                    style: .destructive,
                                    handler: { (action:UIAlertAction) in
                                        
                                        view.performSelector(onMainThread: actionFunction, with: view, waitUntilDone: true)
                                             }
                                    )
    
    alertView.addAction(callAction)
                                    
    view.present(alertView, animated: true, completion: nil)
    
}

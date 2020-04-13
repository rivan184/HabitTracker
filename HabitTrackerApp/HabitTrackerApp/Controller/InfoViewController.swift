//
//  InfoViewController.swift
//  HabitTrackerApp
//
//  Created by Maria Jeffina on 03/04/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var imgMainInfo: UIImageView!
    @IBOutlet weak var txtTitle: UITextView!
    @IBOutlet weak var txtMainContent: UITextView!
    @IBOutlet weak var txtCredit: UITextView!
    
    var infoData :InfoData!// = InfoData(title: "", description: "", image: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Collect and show data
        imgMainInfo.layer.cornerRadius = 10
        imgMainInfo.image = UIImage(named : infoData.image)
        txtTitle.text = infoData.title
//        txtMainContent.attributedText = infoData.description
        txtMainContent.attributedText = infoData.description.htmlToAttributedString
//        print(txtMainContent.attributedText)
//        txtMainContent.text = infoData.description.string
        txtCredit.text = "\(infoData.source)"
        //txtCredit.text = "Source : \(infoData.source)"
        txtCredit.attributedText = infoData.source.htmlToAttributedString
    }
    
    func initData(infoData :InfoData){
        print("Info datanya adalah \(infoData.image)")
        self.infoData = infoData
        
           
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func exitView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //print("pressed")
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

//
//  ViewController.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 31/03/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var habitList: UITableView!
    @IBOutlet weak var noHabitLabel: UILabel!
    
    @IBOutlet weak var scrImage: UIScrollView!
    
    @IBOutlet weak var scrDate: UIScrollView!
    @IBOutlet weak var pageImage: UIPageControl!
    
    var dataManager:DataManager?
    var arrInfoData = [InfoData]()
    //for sign button active
    var buttonBefore :UIButton!
    var selectedDate:String = ""
    var cCalendar = Calendar.current
    var selectedCellPath:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //imageViewSetting()
        setupCell()
        //        setupData()
        setupLongPressGesture()
        print("Home ViewController")
        
        
        //Image Carousel
        scrImage.delegate = self;
        
        //Set Info Data
        arrInfoData = [
            InfoData(title: "What is Covid-19?", description: "Description about Covid-19 Description about Covid-19 Description about Covid-19 Description about Covid-19 Description about Covid-19", image: "testImage", source: "https://finance.detik.com/energi/d-4959835/jokowi-gratiskan-tagihan-listrik-3-bulan"),
            InfoData(title: "Info Covid-19", description: "Description about Info Description about Info Description about Info Description about Info", image: "testImage", source: "https://finance.detik.com/energi/d-4959835/jokowi-gratiskan-tagihan-listrik-3-bulan"),
            InfoData(title: "Symtoms of Covid-19", description: "Description about symtoms Description about symtoms Description about symtoms Description about symtoms Description about symtoms Description about symtoms", image: "testImage", source: "https://finance.detik.com/energi/d-4959835/jokowi-gratiskan-tagihan-listrik-3-bulan"),
        ]
        
        let cDate = Date()
        updateSelectedDate(date: cDate)
        updateView()
        configure(with: arrInfoData)
        configure2()
    }
    
    func updateSelectedDate(date:Date)
    {
        let day = cCalendar.component(.day, from: date)
        let month = cCalendar.component(.month, from: date)
        let year = cCalendar.component(.year, from: date)
        selectedDate = "\(day)-\(month)-\(year)"
    }
    
    func updateView()
    {
        noHabitLabel.isHidden = (dataManager?.habitArr.count != 0)
        habitList.reloadData()
    }
    
    func prepareData(dataManager:DataManager)
    {
        self.dataManager = dataManager
        print("HomeViewControllerPrepare")
    }
    
    //MARK: Image Function
    func imageViewSetting(){
        infoImage.layer.cornerRadius = 10
        
        //Tap Image interaction
        infoImage.isUserInteractionEnabled = true
        infoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))
        
    }
    
    @objc func imageTap(){
        //To Present Modally
        self.performSegue(withIdentifier: "viewInfo", sender: infoImage)
    }
    
    func setupCell(){
        habitList.register(UINib(nibName: "HabitTableViewCell", bundle: nil), forCellReuseIdentifier: "habitCell")
    }
    
    
    
    //Image Carousel
    func configure(with data: [InfoData]) {
        // Get the scrollView width and height
        let scrollViewWidth: CGFloat = scrImage.frame.width
        let scrollViewHeight: CGFloat = scrImage.frame.height
        
        // Loop through all of the images and add them all to the scrollView
        for (index, item) in data.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: scrollViewWidth * CGFloat(index),
                                                      y: 0,
                                                      width: scrollViewWidth,
                                                      height: scrollViewHeight))
            imageView.image = UIImage(named: item.image)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            
            //Tap Image interaction
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))
            
            
            let labelViewTitle = UILabel(frame: CGRect(x: scrollViewWidth * CGFloat(index) + 10,
                                                       y: 0,
                                                       width: scrollViewWidth,
                                                       height: scrollViewHeight))
            
            //Label for title (overlay)
            labelViewTitle.text = item.title
            labelViewTitle.textColor = UIColor.white
            labelViewTitle.font = UIFont.preferredFont(forTextStyle: .title1)
            
            //Label for description(overlay)
            let labelViewContent = UILabel(frame: CGRect(x: scrollViewWidth * CGFloat(index) + 10,
                                                         y: 35,
                                                         width: scrollViewWidth,
                                                         height: scrollViewHeight))
            
            labelViewContent.text = item.description
            labelViewContent.textColor = UIColor.white
            labelViewContent.font = UIFont.preferredFont(forTextStyle: .body)
            labelViewContent.lineBreakMode = .byWordWrapping
            labelViewContent.numberOfLines = 2
            
            
            scrImage.addSubview(imageView)
            scrImage.addSubview(labelViewTitle)
            scrImage.addSubview(labelViewContent)
            
            
        }
        
        // Set the scrollView contentSize
        scrImage.contentSize = CGSize(width: scrImage.frame.width * CGFloat(data.count),
                                      height: scrImage.frame.height)
        
        // Ensure that the pageControl knows the number of pages
        pageImage.numberOfPages = data.count
        
    }
    
   func configure2() {
           
           let scrollViewWidth: CGFloat = scrDate.frame.width
           let scrollViewHeight: CGFloat = scrDate.frame.height
           
           let duration = 14

           let calendar = Calendar.current
           let today = Date()
           var dateStart = calendar.date(byAdding: .day, value: ((duration-1) * -1), to: today)!
           
           //Array for Date
           var arrDate = [Date]()
           for i in 0...duration-1 {
               let index = i
               print("Date End \(dateStart)")
               
               let formatter = DateFormatter()
               
               formatter.dateFormat = "EEEE"
               var day = formatter.string(from: dateStart)
               print("Date End \(day.prefix(3).uppercased())")
               
               
               //For Scroll View Date
               //Ref : https://stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically
               /*let btnDate = UIButton(frame: CGRect(x: (scrollViewWidth / 7 * CGFloat(index)) + 20,
                                                    y: 2.5,
               width: scrollViewWidth / 7,
               height: scrollViewHeight - 5))
               btnDate.backgroundColor = .green
               btnDate.setTitle("Test", for: .normal)
               
               */
    
               let btnDateView = UIButton(frame: CGRect(x: (scrollViewWidth / 6 * CGFloat(index)),
                                                    y: 2.5,
                                                    width: scrollViewWidth / 6.5,
               height: scrollViewHeight - 5))
               btnDateView.backgroundColor = #colorLiteral(red: 0.9137254902, green: 0.9137254902, blue: 0.9137254902, alpha: 1)
               btnDateView.layer.cornerRadius = 10
               
               
               btnDateView.tag = (i + 1)
               btnDateView.addTarget(self, action: #selector(dateAction), for: .touchUpInside)
               
               
               let labelViewDay = UILabel(frame: CGRect(x: (scrollViewWidth / 6 * CGFloat(index)) + 15,
                                                    y: 1,
                                                    width: scrollViewWidth / 6.5,
               height: scrollViewHeight - 35))
               
               //Label for title (overlay)
               labelViewDay.text = day.prefix(3).uppercased()
               labelViewDay.textColor = UIColor.black
               labelViewDay.font = UIFont.preferredFont(forTextStyle: .headline)
               
               
               let labelViewDate = UILabel(frame: CGRect(x: (scrollViewWidth / 6 * CGFloat(index)) + 10,
                                                    y: 2.5,
                                                    width: scrollViewWidth / 6.5,
               height: scrollViewHeight + 25))
               
               //Label for title (overlay)
               formatter.dateFormat = "dd"
               day = formatter.string(from: dateStart)
               
               labelViewDate.text = day
               labelViewDate.textColor = UIColor.black
               labelViewDate.font = UIFont.preferredFont(forTextStyle: .largeTitle)
               //labelViewDate.font = UIFont(name: "SF Pro Text", size: 30)
               
               
               if(today == dateStart){
                   btnDateView.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
                   labelViewDate.textColor = UIColor.white
                   labelViewDay.textColor = UIColor.white
               }
               
               scrDate.addSubview(btnDateView)
               scrDate.addSubview(labelViewDay)
               scrDate.addSubview(labelViewDate)
               
               arrDate.append(dateStart)
               dateStart = calendar.date(byAdding: .day, value: 1, to: dateStart)!
           }
           
           // Set the scrollView contentSize
          scrDate.contentSize = CGSize(width: scrDate.frame.width / 6 * CGFloat(duration),
                                          height: scrDate.frame.height)
           
           scrDate.setContentOffset(CGPoint(x: scrDate.frame.width / 6 * CGFloat(duration - 6), y: 0), animated: true)
           
       }
        
        @objc func dateAction(sender :UIButton){
            
            let duration = 14
            let calendar = Calendar.current
            let today = Date()
            let chooseDate = calendar.date(byAdding: .day, value: ((duration-(sender.tag)) * -1), to: today)!
            
            let day = calendar.component(.day, from: chooseDate)
            let month = calendar.component(.month, from: chooseDate)
            let year = calendar.component(.year, from: chooseDate)
            let dateString = "\(day)-\(month)-\(year)"
            
            print("Date Start = \(dateString)")
            //format date : tanggal - bulan - tahun
            sender.layer.borderWidth = 1
            sender.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            
            if(buttonBefore != nil){
                buttonBefore.layer.borderWidth = 0
            }
            
            buttonBefore = sender
        }
        
    
    
    
}

//MARK: TableView Delegate & Data Source
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager?.habitArr.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "habitCell", for: indexPath) as! HabitTableViewCell
        //        cell.model = habitModel[indexPath.row]
        cell.model = dataManager?.habitArr[indexPath.row]
        cell.date = selectedDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        selectedCellPath = indexPath
        let cell = tableView.cellForRow(at: indexPath)
        cell?.isHighlighted = true
        return true
    }
    
    
    
    //Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("Tapped index: ", indexPath.row)
        let selectedHabit = dataManager?.habitArr[indexPath.row]
        let progress = selectedHabit?.currentGoalFor(date: selectedDate)
        let ratio = Float(progress!) / Float(selectedHabit!.goal)
        //If a habit hasnt's been completed, otherwise do nothing
        if ratio < 1 {
            //Increment habit progress
            selectedHabit?.update(date: selectedDate, value: progress!+1)
            //            habitModel[indexPath.row].tapProgress += 1
        }
        //Updating tableView
        //        let cell = tableView.cellForRow(at: indexPath)
        //        cell?.isSelected = true
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        //        let cell = tableView.cellForRow(at: indexPath)
        //        cell?.isHighlighted = false
    }
    
}
// MARK: UIScrollViewDelegate
// For page indicator
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrImage: UIScrollView){
        let pageWidth:CGFloat = scrImage.frame.width
        let currentPage:CGFloat = floor((scrImage.contentOffset.x-pageWidth/2)/pageWidth)+1
        pageImage.currentPage = Int(currentPage)
    }
}


//MARK: Handle Long Tap Gesture
extension HomeViewController {
    func setupLongPressGesture(){
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPres(_:)))
        //Long Press Duration in seconds
        longPressRecognizer.minimumPressDuration = 0.6
        self.view.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func handleLongPres(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.habitList)
            if let indexPath = habitList.indexPathForRow(at: touchPoint)
            {
                //Access the Habit detail view based on indexPath
                //Segue to habitDetailView
                let habitData = dataManager?.habitArr[indexPath.row]
                print(habitData?.description())
                if selectedCellPath != nil
                {
                    let cell = habitList.cellForRow(at: selectedCellPath!) as! HabitTableViewCell
                    cell.isHighlighted = false
                    
                }
                self.performSegue(withIdentifier: "showHabitDetail", sender: habitData)
                
            }
        }
    }
}


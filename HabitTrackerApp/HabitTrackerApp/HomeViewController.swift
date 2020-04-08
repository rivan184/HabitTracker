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
    
    @IBOutlet weak var scrImage: UIScrollView!
    
    @IBOutlet weak var pageImage: UIPageControl!
    
    var dataManager:DataManager?
    var selectedDate:String = ""
    var cCalendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //imageViewSetting()
        setupCell()
//        setupData()
        setupLongPressGesture()
        print("Home ViewController")
        scrImage.delegate = self;
        
        let images: [UIImage] = [UIImage(named: "testImage")!,
        UIImage(named: "testImage")!,
        UIImage(named: "testImage")!,
        UIImage(named: "testImage")!,
        UIImage(named: "testImage")!,
        UIImage(named: "testImage")!]
        
        let cDate = Date()
        updateSelectedDate(date: cDate)
        
        configure(with: images)
        
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
    
    // MARK: Image Carousel
    func configure(with images: [UIImage]) {
        
        pageImage.pageIndicatorTintColor = UIColor(named: "black")
        pageImage.currentPageIndicatorTintColor = UIColor(named: "black")
       
        
        // Get the scrollView width and height
        let scrollViewWidth: CGFloat = scrImage.frame.width
        let scrollViewHeight: CGFloat = scrImage.frame.height
        
        // Loop through all of the images and add them all to the scrollView
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(frame: CGRect(x: scrollViewWidth * CGFloat(index),
                                                      y: 0,
                                                      width: scrollViewWidth,
                                                      height: scrollViewHeight))
            imageView.image = image
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 10
            
            let labelViewTitle = UILabel(frame: CGRect(x: scrollViewWidth * CGFloat(index),
            y: 0,
            width: scrollViewWidth,
            height: scrollViewHeight))
            
            labelViewTitle.text = "Title of Article \(index)"
            labelViewTitle.textColor = UIColor.white
            labelViewTitle.font = UIFont.preferredFont(forTextStyle: .title1)
            //labelViewTitle.font = UIFont..
            
            let labelViewContent = UILabel(frame: CGRect(x: scrollViewWidth * CGFloat(index),
            y: 30,
            width: scrollViewWidth,
            height: scrollViewHeight))
            
            labelViewContent.text = "This is Content of Article"
            labelViewContent.textColor = UIColor.white
            labelViewContent.font = UIFont.preferredFont(forTextStyle: .body)

            
            scrImage.addSubview(imageView)
            scrImage.addSubview(labelViewTitle)
            scrImage.addSubview(labelViewContent)
        }
        
        // Set the scrollView contentSize
        scrImage.contentSize = CGSize(width: scrImage.frame.width * CGFloat(images.count),
                                        height: scrImage.frame.height)
        
        // Ensure that the pageControl knows the number of pages
        pageImage.numberOfPages = images.count
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var habitData:Habit? = nil
        if sender != nil
        {
            habitData = sender as? Habit
        }
        
        
        let habitDataVC = segue.destination as? HabitDataVC
        let rootVC = tabBarController as! TabBarViewController
        habitDataVC?.fillPredefinedData(defaultData: habitData,rootVC:rootVC)
        
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
        tableView.reloadData()
    }
}

// MARK: UIScrollViewDelegate
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrImage: UIScrollView){
        print("scroll run")
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
        longPressRecognizer.minimumPressDuration = 1.0
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
                self.performSegue(withIdentifier: "showHabitDetail", sender: habitData)
                
            }
        }
    }
}


//
//  ViewController.swift
//  HabitTrackerApp
//
//  Created by Bernardinus on 31/03/20.
//  Copyright © 2020 Bernardinus. All rights reserved.
//

import UIKit
func updateAttributeString (fullText: String, changeText: String, attributeKey:NSAttributedString.Key, value:Any) -> NSMutableAttributedString
{
    let strNumber: NSString = fullText as NSString
    let range = (strNumber).range(of: changeText)
    let attribute = NSMutableAttributedString.init(string: fullText)
    attribute.addAttribute(.font, value: UIFont.systemFont(ofSize: 30), range: range)
    print(attribute)
    return attribute
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var habitList: UITableView!
    @IBOutlet weak var noHabitLabel: UILabel!
    
    @IBOutlet weak var scrImage: UIScrollView!
    
    @IBOutlet weak var scrDate: HorizontalCalendar!
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
            InfoData(title: "What is Covid-19?",
                     description: NSMutableAttributedString.init(string: "On February 11, 2020 the World Health Organization announced an official name for the disease that is causing the 2019 novel coronavirus outbreak, first identified in Wuhan China. The new name of this disease is coronavirus disease 2019, abbreviated as COVID-19. In COVID-19, 'CO' stands for 'corona,' 'VI' for 'virus,' and 'D' for disease. Formerly, this disease was referred to as \"2019 novel coronavirus\" or \"2019-nCoV\".\n\n There are many types of human coronaviruses including some that commonly cause mild upper-respiratory tract illnesses. COVID-19 is a new disease, caused be a novel (or new) coronavirus that has not previously been seen in humans. The name of this disease was selected following the World Health Organization (WHO) best practice for naming of new human infectious diseases."),
                     image: "covid19",
                     source: "Images: CDC/ Alissa Eckert, MS; Dan Higgins, MAMS\nSource::https://www.cdc.gov/coronavirus/2019-ncov/faq.html#Coronavirus-Disease-2019-Basics (Why is the disease being called coronavirus disease 2019, COVID-19?)"),
            InfoData(
                    title: "Symtoms of Covid-19",
                    description: NSMutableAttributedString.init(string: "Reported illnesses have ranged from mild symptoms to severe illness and death for confirmed coronavirus disease 2019 (COVID-19) cases.\n\nThese symptoms may appear 2-14 days after exposure (based on the incubation period of MERS-CoV viruses).\n- Fever\n- Cough\n- Shortness of breath\n\nWhen to Seek Medical Attention\n\nIf you develop emergency warning signs for COVID-19 get medical attention immediately. Emergency warning signs include*:\n- Trouble breathing\n- Persistent pain or pressure in the chest\n- New confusion or inability to arouse\n- Bluish lips or face\n\n*This list is not all inclusive. Please consult your medical provider for any other symptoms that are severe or concerning."),
                    image: "symptoms",
                    source: "Images:https://unsplash.com/photos/-CDN2nTKfrA (Photo by Brittany Colette on Unsplash)\nSource: https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/symptoms.html"),
            InfoData(
                    title: "If You Are Sick",
                    description: NSMutableAttributedString.init(string: "If you are sick with COVID-19 or suspect you are infected with the virus that causes COVID-19, you should take steps to help prevent the disease from spreading to people in your home and community.\n\nIf you think you have been exposed to COVID-19 and develop a fever and symptoms, such as cough or difficulty breathing, call your healthcare provider for medical advice.\n\nWhat to Do If You Are Sick\n\nStay home except to get medical care\n\n- Stay home. Most people with COVID-19 have mild illness and can recover at home without medical care. Do not leave your home, except to get medical care. Do not visit public areas.\n- Take care of yourself. Get rest and stay hydrated.\n- Stay in touch with your doctor. Call before you get medical care. Be sure to get care if you have trouble breathing, or have any other emergency warning signs, or if you think it is an emergency.\n- Avoid public transportation, ride-sharing, or taxis.\n\nMonitor your symptoms\n\n- Common symptoms of COVID-19 include fever and cough. Trouble breathing is a more serious symptom that means you should get medical attention.\n- Follow care instructions from your healthcare provider and local health department. Your local health authorities may give instructions on checking your symptoms and reporting information."),
                    image: "ifyouaresick",
                    source: "Images: https://unsplash.com/photos/ioZc-2TpcjY (Photo by CDC on Unsplash)\nSource: https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/steps-when-sick.html"
                    ),
        ]
        
        var symtomsInfo = arrInfoData[2]
//        symtomsInfo.description = updateAttributeString(fullText: symtomsInfo.description.string, changeText: "When to Seek Medical Attention", attributeKey: NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 30))
        symtomsInfo.description = updateAttributeString(fullText: symtomsInfo.description.string, changeText: symtomsInfo.description.string, attributeKey: NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 30))
        
//
        
        let cDate = Date()
        updateSelectedDate(date: cDate)
        updateView()
        configureImageInfo(with: arrInfoData)
        configureHorizontalCalendar()
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
    func configureImageInfo(with data: [InfoData]) {
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
            labelViewTitle.font = UIFont.boldSystemFont(ofSize: 24)
            
            //Label for description(overlay)
            let labelViewContent = UILabel(frame: CGRect(x: scrollViewWidth * CGFloat(index) + 10,
                                                         y: 50,
                                                         width: scrollViewWidth-10,
                                                         height: scrollViewHeight))
            
            labelViewContent.text = item.description.string
            labelViewContent.textColor = UIColor.white
            labelViewContent.font = UIFont.systemFont(ofSize: 14)
            labelViewContent.lineBreakMode = .byWordWrapping
            labelViewContent.numberOfLines = 3
            
            
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
    
    func configureHorizontalCalendar() {
        
        let scrollViewWidth: CGFloat = scrDate.frame.width
        let scrollViewHeight: CGFloat = scrDate.frame.height
        
        let duration = 14
        
        let calendar = Calendar.current
        let today = Date()
        var dateStart = calendar.date(byAdding: .day, value: (duration-1) * -1, to: today)!
        scrDate.showsHorizontalScrollIndicator = false;
        scrDate.showsVerticalScrollIndicator = false;
        scrDate.delegate = self
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
            btnDateView.isExclusiveTouch = true
            
            
            
            btnDateView.tag = (i + 1)
            btnDateView.addTarget(self, action: #selector(dateAction), for: .touchUpInside)
            
            
            let labelViewDay = UILabel(frame: CGRect(x: (scrollViewWidth / 6 * CGFloat(index)) + 15,
                                                     y: 1,
                                                     width: scrollViewWidth / 6.5,
                                                     height: scrollViewHeight - 35))
            
            //Label for title (overlay)
            labelViewDay.text = day.prefix(3).uppercased()
            labelViewDay.textColor = UIColor.black
            labelViewDay.font = UIFont.monospacedDigitSystemFont(ofSize: 12, weight: .heavy)
            
            
            let labelViewDate = UILabel(frame:
                CGRect(
                    x: (scrollViewWidth / 6 * CGFloat(index)) + 10,
                    y: 2.5,
                    width: 40,
                    height: 25
                )
            )
            
            //Label for title (overlay)
            formatter.dateFormat = "dd"
            day = formatter.string(from: dateStart)
            
            labelViewDate.text = day
            labelViewDate.textColor = UIColor.black
            labelViewDate.font = UIFont.systemFont(ofSize: 30, weight:.semibold)
            //labelViewDate.font = UIFont(name: "SF Pro Text", size: 30)
            //            labelViewDate.frame = CGRect(origin: cgpoi,
            //                                         size: labelViewDate.frame.size)
            
            btnDateView.addSubview(labelViewDate)
            labelViewDate.textAlignment = .center
            labelViewDate.frame = CGRect(
                origin: CGPoint(x: btnDateView.frame.width * 0.5 - labelViewDate.frame.size.width * 0.5,
                                y: btnDateView.frame.height * 0.5),
                size: labelViewDate.frame.size)
            
            btnDateView.addSubview(labelViewDay)
            
            labelViewDay.frame = CGRect(origin: CGPoint.zero, size: labelViewDay.frame.size)
            labelViewDay.textAlignment = .center
            labelViewDay.frame = CGRect(
                origin: CGPoint(x: btnDateView.frame.width * 0.5 - labelViewDay.frame.size.width * 0.5,
                                y: 0),//btnDateView.frame.height * 0.5 - labelViewDay.frame.size.height),
                size: labelViewDay.frame.size)
            
            
            
            if(today == dateStart){
                btnDateView.backgroundColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
                labelViewDate.textColor = UIColor.white
                labelViewDay.textColor = UIColor.white
            }
            
            scrDate.addSubview(btnDateView)
            //               scrDate.addSubview(labelViewDay)
            //               scrDate.addSubview(labelViewDate)
            
            arrDate.append(dateStart)
            dateStart = calendar.date(byAdding: .day, value: 1, to: dateStart)!
        }
        
        // Set the scrollView contentSize
        scrDate.contentSize = CGSize(width: scrDate.frame.width / 6 * CGFloat(duration),
                                     height: scrDate.frame.height)
        
        scrDate.setContentOffset(CGPoint(x: scrDate.frame.width / 6 * CGFloat(duration - 6), y: 0), animated: true)
        
    }
    
    @objc func dateAction(sender :UIButton){
        
        if(sender == buttonBefore) {return}
        
        let duration = 14
        let calendar = Calendar.current
        let today = Date()
        let chooseDate = calendar.date(byAdding: .day, value: ((duration-(sender.tag)) * -1), to: today)!
        
        let day = calendar.component(.day, from: chooseDate)
        let month = calendar.component(.month, from: chooseDate)
        let year = calendar.component(.year, from: chooseDate)
        let dateString = "\(day)-\(month)-\(year)"
        selectedDate = dateString
        habitList.reloadData()
        
        print("Date Start = \(dateString)")
        //format date : tanggal - bulan - tahun
        sender.layer.borderWidth = 1.5
        sender.layer.borderColor = #colorLiteral(red: 0.1803921569, green: 0.1803921569, blue: 0.1803921569, alpha: 1)
        
        if(buttonBefore != nil){
            buttonBefore.layer.borderWidth = 0
        }
        
        buttonBefore = sender
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showHabitDetail"
        {
            var habitData:Habit? = nil
            if sender != nil
            {
                habitData = sender as? Habit
            }
            
            
            let habitDataVC = segue.destination as? HabitDataVC
            let rootVC = tabBarController as! TabBarViewController
            habitDataVC?.fillPredefinedData(defaultData: habitData,rootVC:rootVC)
        }
        else
        {
            if let infoView = segue.destination as? InfoViewController{
                infoView.initData(infoData: arrInfoData[pageImage.currentPage])
            }

        }
        
        
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
        let selectedHabit = dataManager?.habitArr[indexPath.row]
        let progress = selectedHabit?.currentGoalFor(date: selectedDate)
        let ratio = Float(progress!) / Float(selectedHabit!.goal)
        if ratio < 1 {
            //Increment habit progress
            selectedHabit?.update(date: selectedDate, value: progress!+1)
        }
        
        tableView.reloadData()
    }
}
// MARK: UIScrollViewDelegate
// For page indicator
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrImage: UIScrollView){
        
        if scrImage == self.scrImage
        {
            let pageWidth:CGFloat = scrImage.frame.width
            let currentPage:CGFloat = floor((scrImage.contentOffset.x-pageWidth/2)/pageWidth)+1
            pageImage.currentPage = Int(currentPage)
        }
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


//
//  ViewController.swift
//  timer-count
//
//  Created by Tommy Lee on 5/9/2018.
//  Copyright © 2018 Tommy Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func resetAll(_ sender: Any) {
        timer.invalidate()
        firstTimer.invalidate()
        resetTimer()
        resetTwentyFour(self)
    }
    @IBOutlet weak var timerChangeMode: UIButton!
    @IBAction func timeStart(_ sender: Any) {
       
        if self.firstTapped == false {
            secondsToTime()
            
            self.firstTapped = true
        } else {
            firstTimer.invalidate()
            self.firstTapped = false
        }
        
        /*   if self.resumeTapped == false {
            firstTimer.invalidate()
            self.resumeTapped = true
        } else {
            
            self.resumeTapped = false
        }
 */
    }
    @IBAction func homemin(_ sender: Any) {
        DispatchQueue.main.async{
            if self.scoreHome > 0
            {
                self.scoreHome -= 1
                self.homescoreLabel.text = self.homescoreString(score: self.scoreHome)
            }
            if self.scoreHome < 100 && self.homegetmax
            {
                self.homegetmax = false
                self.leftscoreConstrain.constant = 180
            }
        }
    
    }
    @IBAction func addmin(_ sender: Any) {

            seconds += 60
            timeLabel.text = timeString(time: TimeInterval(seconds))
    
    }
    @IBAction func minusmin(_ sender: Any) {
        if seconds >= 60
        {
            seconds -= 60
            timeLabel.text = timeString(time: TimeInterval(seconds))
        }
        
    }
    @IBAction func addsec(_ sender: Any) {

            seconds += 1
            timeLabel.text = timeString(time: TimeInterval(seconds))
 
    }
    
    @IBAction func minsec(_ sender: Any) {
        if seconds > 0
        {
            updateTimer()
        }
    }
    @IBAction func addtwentyFour(_ sender: Any) {
        if twentyfour < twentyfourDifMode
        {
            twentyfour += 1
        }
        twentyfourLabel.text = twentyFourString(time: TimeInterval(twentyfour))
    }
    
    @IBAction func mintwentyFour(_ sender: Any) {
        if twentyfour > 0
        {
            twentyfour -= 1
        }
        twentyfourLabel.text = twentyFourString(time: TimeInterval(twentyfour))
    }
    
    
    @IBAction func resetAway(_ sender: Any) {
        DispatchQueue.main.async{
           self.scoreAway = 0
            self.awayscoreLabel.text = self.awayscoreString(score: self.scoreAway)
            if self.awaygetmax
            {
                self.rightscoreConstrain.constant = 180
                self.awaygetmax = false
            }
        }
    }
    func secondsToTime(){
        firstTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    @IBAction func resetHome(_ sender: Any) {
        DispatchQueue.main.async{
            self.scoreHome = 0
            self.homescoreLabel.text = self.homescoreString(score: self.scoreHome)
            if self.homegetmax
            {
                self.leftscoreConstrain.constant = 180
                self.homegetmax = false
            }
        }
    }
    @objc func updateTimer(){
        seconds -= 1
        if seconds <= 0
        {
            resetTimer()
        }
        
        timeLabel.text = timeString(time: TimeInterval(seconds))
        
    }
    @IBAction func homeadd(_ sender: Any) {
        DispatchQueue.main.async{
            self.scoreHome += 1
            self.homescoreLabel.text = self.homescoreString(score: self.scoreHome)
            if self.scoreHome >= 100 && !self.homegetmax
            {
                self.homegetmax = true
                self.leftscoreConstrain.constant = 200
            }
        }
       
    }
    
    @IBAction func awayadd(_ sender: Any) {
        DispatchQueue.main.async{
            self.scoreAway += 1
             self.awayscoreLabel.text = self.awayscoreString(score: self.scoreAway)
            self.awayscoreLabel.sizeToFit()
            if self.scoreAway >= 100 && !self.awaygetmax
            {
                self.awaygetmax = true
                 self.rightscoreConstrain.constant = 200
            }
        }
    }

    @IBAction func timerchangeMode(_ sender: Any) {
      
        let tpx = twentyfourDifMode == 24 ? String(24) : String(14)
         twentyfourDifMode = twentyfourDifMode == 24 ? 14: 24
        timerChangeMode.setTitle(tpx, for: .normal)
        self.twentyfourLabel.text = String(twentyfourDifMode)
        self.twentyfour = twentyfourDifMode
 
    }
    
    @IBAction func resetTwentyFour(_ sender: Any) {
        
        
        twentyfour = twentyfourDifMode
        twentyfourLabel.text = String(twentyfour)
        if runningTimer
        {
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        }
    }
    func resetTimer(){
        seconds = 600
        twentyfour = twentyfourDifMode
        firstTapped = false
        runningTimer = false
        firstTimer.invalidate()
        timer.invalidate()
        timeLabel.text = timeString(time: TimeInterval(seconds))
        twentyfourLabel.text = twentyFourString(time: TimeInterval(twentyfour)
        )
    }
    @IBAction func startTwentyFour(_ sender: Any) {
        if !runningTimer
        {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
            runningTimer = true
        }
        else {
            timer.invalidate()
            runningTimer = false
        }
    }
    @IBOutlet weak var startTimer: UIButton!
    @IBAction func startTimer(_ sender: Any) {
        
        timeStart(self)
        startTwentyFour(self)
    }

    @objc func counter(){
        twentyfour -= 1
        
        if twentyfour == 0
        {
            twentyfour = twentyfourDifMode
        }
        twentyfourLabel.text = twentyFourString(time: TimeInterval(twentyfour))
    }
    @IBAction func awaymin(_ sender: Any) {
        DispatchQueue.main.async{
            if self.scoreAway > 0
        {
            self.scoreAway -= 1
            self.awayscoreLabel.text = self.awayscoreString(score: self.scoreAway)
            
        }
            if self.scoreAway < 100 && self.awaygetmax
            {
                self.awaygetmax = false
                self.rightscoreConstrain.constant = 180
            }
        }
    }
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var homescoreLabel: UILabel!
    @IBOutlet weak var awayscoreLabel: UILabel!
    var scoreHome = 0
    var runningTimer = false
    var seconds = 600
    var scoreAway = 0
    var twentyfour = 24
    var homegetmax = false
    var awaygetmax = false
    var twentyfourDifMode = 24
    @IBOutlet weak var twentyfourLabel: UILabel!
    var firstTimer = Timer()
    var timer = Timer()
    var firstTapped = false
    @IBOutlet weak var rightscoreConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var rightTrail: NSLayoutConstraint!
    @IBOutlet weak var leftscoreConstrain: NSLayoutConstraint!
    
    @IBAction func leftarrow(_ sender: Any) {
        leftarrow.isHidden = true
        rightarrow.isHidden = false
    }
    
    @IBOutlet weak var leftarrow: UIButton!
    @IBOutlet weak var rightarrow: UIButton!
    
    @IBAction func rightarrow(_ sender: Any) {
        leftarrow.isHidden = false
        rightarrow.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        homescoreLabel.sizeToFit()
        awayscoreLabel.sizeToFit()
        homescoreLabel.baselineAdjustment = .alignCenters
        // Do any additional setup after loading the view, typically from a nib.
    }
    func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        
        return String(format:"%02i:%02i", minutes, seconds)
        
    }
    func twentyFourString(time:TimeInterval) -> String {
        let seconds = Int(time) % 60
        
        return String(format:"%02i", seconds)
        
    }
    func homescoreString(score: Int) -> String {

        
        return String(format:"%02i", Int(score))
        
    }
    func awayscoreString(score: Int) -> String {
        
        
        return String(format:"%02i", Int(score))
        
    }
    func awayscoreString(time:TimeInterval) -> String {
        let seconds = Int(time) % 60
        
        return String(format:"%02i", seconds)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


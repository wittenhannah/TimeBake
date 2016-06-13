//
//  ViewController.swift
//  TimeBake
//
//  Created by Tomas Witten-Hannah on 6/12/16.
//  Copyright © 2016 Tomas Witten-Hannah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = NSTimer() //make a timer variable, but do do anything yet
    let timeInterval:NSTimeInterval = 0.05
    let timerEnd:NSTimeInterval = 10.0
    var timeCount:NSTimeInterval = 60.0 // counter for the time
    var name = "Timer Name"
    var alert = "Food"
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var timerName: UITextField!
    @IBOutlet weak var setTimerName: UIButton!
    
    // Update timer name
    @IBAction func nameUpdated(sender: AnyObject) {
        alert = timerName.text!
        print(alert)
    }
    
    // Trigger updateCounter() when date selection changes
    @IBAction func datePickerChanged(sender: UIDatePicker) {
        updateCounter()
    }
    
    // Starts the timer
    @IBAction func startTimer(sender: UIButton) {
        if !timer.valid{ //prevent more than one timer on the thread
            timerLabel.text = timeString(timeCount)
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval,
                                                           target: self,
                                                           selector: #selector(ViewController.timerDidEnd(_:)),
                                                           userInfo: "Timer Done !",
                                                           repeats: true) //repeating timer in the second iteration
        }
    }
    
    // Stops timer
    @IBAction func stopTimer(sender: UIButton) {
        timer.invalidate()
    }
    
    // Resets the timer to value from date picker
    @IBAction func resetTimer(sender: UIButton) {
        timer.invalidate()
        updateCounter()
    }
    
    // Update the timerLabel based on the duraction picked with datePicker
    func updateCounter() {
        print(datePicker.countDownDuration) // debug display of time picked
        timeCount = datePicker.countDownDuration
        timerLabel.text = timeString(timeCount)
    }
    
    // Format the string for display in the timer label
    func timeString(time:NSTimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = time - Double(minutes) * 60
        let secondsFraction = seconds - Double(Int(seconds))
        return String(format:"%02i:%02i.%01i",minutes,Int(seconds),Int(secondsFraction * 10.0))
    }
    
    // Decrement the time until reaching 0
    func timerDidEnd(timer:NSTimer){

        timeCount = timeCount - timeInterval
        if timeCount <= 0 {  //test for target time reached.
            timerLabel.text = alert + " Done!"
            sendNotification()
            timer.invalidate()
        } else { //update the time on the clock if not reached
            timerLabel.text = timeString(timeCount)
        }
        
    }
    
    // Update the timerLabel based on the duraction picked with datePicker
    func sendNotification() {
        
        guard let settings = UIApplication.sharedApplication().currentUserNotificationSettings() else { return }
        
        // Check if user has allowed notifcations
        if settings.types == .None {
            let ac = UIAlertController(title: "Can't schedule", message: "Either we don't have permission to schedule notifications, or we haven't asked yet.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
        
        let notification = UILocalNotification()
        notification.fireDate = NSDate(timeIntervalSinceNow: 0)
        notification.alertBody = alert + " Done!"
        notification.alertAction = "be awesome!"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["CustomField1": "w00t"]
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.countDownDuration = 60.0; // Initial value for datePicker
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


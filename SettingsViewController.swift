//
//  SettingsViewController.swift
//  TimeBake
//
//  Created by Tomas Witten-Hannah on 6/12/16.
//  Copyright © 2016 Tomas Witten-Hannah. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // Request Permission to send notifications
    @IBAction func enableNotifications(sender: AnyObject) {
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
    }
    

}
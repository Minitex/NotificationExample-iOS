//
//  ViewController.swift
//  NotificationExample
//
//  Created by Vui Nguyen on 9/12/18.
//  Copyright © 2018 Minitex. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UNUserNotificationCenterDelegate {

  @IBAction func sendNotification(_ sender: Any) {
    print("send local notification")

    //creating the notification content
    let content = UNMutableNotificationContent()

    //adding title, subtitle, body and badge
    content.title = "Book Ready to Check Out"
    content.subtitle = "Book Title Ready to Check Out"
    content.body = "You'll Have the Option to Check Out Book from Here Later"
    content.badge = 1

    //getting the notification trigger
    //it will be called after 2 seconds
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)

    //getting the notification request
    let request = UNNotificationRequest(identifier: "SimplyEIOSNotification", content: content, trigger: trigger)

    UNUserNotificationCenter.current().delegate = self

    //adding the notification to notification center
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }
  
  @IBAction func startTimer(_ sender: Any) {
    print("start the notification timer")
  }
  override func viewDidLoad() {
    super.viewDidLoad()

    // request for user authorization
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in

    })
  }

  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    //displaying the ios local notification when app is in foreground
    completionHandler([.alert, .badge, .sound])
  }

}


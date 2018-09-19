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

  enum AvailabilityTimes: Int {
    case now = 0, thirtySeconds, oneMinute, fiveMinutes, oneDay, threeDays, sevenDays
  }

  //var timeSelected: Double = 0
  var availabilityDate: Date = Date()
  let notificationCenter = UNUserNotificationCenter.current()

  // MARK: Outlets
  @IBOutlet weak var availabilitySegmentControl: UISegmentedControl!
  @IBOutlet weak var availabilityDateLabel: UILabel!
  
  // MARK: Actions
  @IBAction func changeAvailabilityDate(_ sender: Any) {
    // now, change the book availability depending on segment control
  }

  @IBAction func pollServer(_ sender: Any) {
    let alert = UIAlertController(title: "Book Due Date", message: availabilityDate.description, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
      print("The \"OK\" alert occurred.")
    }))
    alert.addAction(UIAlertAction(title: NSLocalizedString("Send Notification", comment: "Send Notification"), style: .default, handler: { _ in
      print("Sending a notification!")
      self.createNotification()
    }))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func printPendingNotifications(_ sender: Any) {
    UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
      print("About to print some pending notifications, yo!")
      for request in requests {
        print(request)
      }
    })
  }

  @IBAction func sendNotification(_ sender: Any) {
    print("send local notification")
    createNotification()
  }

  // MARK: ViewController
  override func viewDidLoad() {
    super.viewDidLoad()

    // request for user authorization
    notificationCenter.requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, error in
    })

    availabilityDate = ServerData().pollServer()
    print("Due date is: \(availabilityDate)")
    availabilityDateLabel.text = "Availability Date: " + availabilityDate.description
  }

  // MARK: UNUserNotificationCenterDelegate

  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    //displaying the ios local notification when app is in foreground
    completionHandler([.alert, .badge, .sound])
  }

  // MARK: helper functions
  func createNotification(timeSeconds: Int = 3, repeat: Bool = false, completionHandler: (() -> Void)? = nil) -> Void {
    let content = UNMutableNotificationContent()

    //adding title, subtitle, body and badge
    content.title = "Book Title Ready to Check Out"
    content.subtitle = "Availability Date: " + availabilityDate.description
    content.body = "You'll Have the Option to Check Out Book from Here Later"
    content.badge = 1

    //getting the notification trigger
    //it will be called after X seconds
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(timeSeconds), repeats: false)

    //getting the notification request
    let request = UNNotificationRequest(identifier: "SimplyEIOSNotification", content: content, trigger: trigger)

    UNUserNotificationCenter.current().delegate = self

    //adding the notification to notification center
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
  }

  // based on the availability date, schedule the next notification
  private func scheduleNextNotification(availabilityDate: Date) -> Void {

  }
}


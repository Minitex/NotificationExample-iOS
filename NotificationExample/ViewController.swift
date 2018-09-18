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

  enum NotificationTimes: Int {
    case none = 0, half, one, five, ten, fifteen
  }

  var timer = Timer()
  var timerIsOn = false
  var timeRemaining: Double = 0
  var timeSelected: Double = 0

  // MARK: Outlets
  @IBOutlet weak var timerSegmentControl: UISegmentedControl!
  @IBOutlet weak var timerButton: UIButton!
  @IBOutlet weak var timerLabel: UILabel!

  // MARK: Actions
  @IBAction func printPendingNotifications(_ sender: Any) {
    UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
      print("About to print some pending notifications, yo!")
      for request in requests {
        print(request)
      }
    })
  }


  @IBAction func timeSelected(_ sender: Any) {
    var minutes: Double = 0
    switch(timerSegmentControl.selectedSegmentIndex) {
    case NotificationTimes.none.rawValue:
      print("none selected")
    case NotificationTimes.half.rawValue:
      print("half minute selected")
      minutes = 0.5
    case NotificationTimes.one.rawValue:
      print("one selected")
      minutes = 1
    case NotificationTimes.five.rawValue:
      print("five selected")
      minutes = 5
    case NotificationTimes.ten.rawValue:
      print("ten selected")
      minutes = 10
    case NotificationTimes.fifteen.rawValue:
      print("fifteen selected")
      minutes = 15
    default:
      print("none selected")
    }

    // totalTime in seconds
    timeSelected = 60 * minutes
    displayTimerRunning(timeSelected)
  }


  @IBAction func sendNotification(_ sender: Any) {
    print("send local notification")
    createNotification()
  }
  
  @IBAction func startStopTimer(_ sender: Any) {

    // this is where we start the timer going and submit the notification request
    // allow the timer to continue when app is backgrounded as well
    // I actually have NO idea how well this timer display idea will work, when app is in the background
    // also, don't know if we can cancel a notification request once it's sent
    if timerIsOn == true {
      timerSegmentControl.isEnabled = true
      for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
        timerButton.setTitle("Start Timer", for: state)
      }
      timer.invalidate()
      timerIsOn = false
      print("stopped the notification timer")
    } else {
      if timeSelected == 0 { return }
      timerSegmentControl.isEnabled = false
      for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
        timerButton.setTitle("Stop Timer", for: state)
      }

      timeRemaining = timeSelected

      // it does not make sense to pass the timer code as the completion handler for the notification
      createNotification(timeSeconds: Int(timeRemaining), repeat: false, completionHandler: nil)
      timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerRunning), userInfo: nil, repeats: true)
      timerIsOn = true
      print("started the notification timer")
    }
  }

  // MARK: ViewController
  override func viewDidLoad() {
    super.viewDidLoad()


    for state: UIControl.State in [.normal, .highlighted, .disabled, .selected, .focused, .application, .reserved] {
      timerButton.setTitle("Start Timer", for: state)
    }

    // request for user authorization
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in

    })
  }

  // MARK: UNUserNotificationCenterDelegate

  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

    //displaying the ios local notification when app is in foreground
    completionHandler([.alert, .badge, .sound])
  }

  // MARK: helper functions
  func displayTimerRunning(_ remainingTime: Double) -> Void {
    let minutesLeft = Int(remainingTime) / 60 % 60
    let secondsLeft = Int(remainingTime) % 60
    timerLabel.text = "\(minutesLeft):\(secondsLeft)"
  }

  @objc func timerRunning() -> Void {
    timeRemaining -= 1
    displayTimerRunning(timeRemaining)
    if timeRemaining == 0 {
      timerIsOn = true
      startStopTimer(self)
    }
  }

  func createNotification(timeSeconds: Int = 3, repeat: Bool = false, completionHandler: (() -> Void)? = nil) -> Void {
    let content = UNMutableNotificationContent()

    //adding title, subtitle, body and badge
    content.title = "Book Ready to Check Out"
    content.subtitle = "Book Title Ready to Check Out"
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
}


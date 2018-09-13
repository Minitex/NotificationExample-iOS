//
//  ViewController.swift
//  NotificationExample
//
//  Created by Vui Nguyen on 9/12/18.
//  Copyright © 2018 Minitex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBAction func sendNotification(_ sender: Any) {
    print("send local notification")
  }
  
  @IBAction func startTimer(_ sender: Any) {
    print("start the notification timer")
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }


}


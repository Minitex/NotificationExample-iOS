//
//  NotificationTableViewController.swift
//  NotificationExample
//
//  Created by Vui Nguyen on 9/20/18.
//  Copyright © 2018 Minitex. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationViewController: UITableViewController {

  var notificationRequestStrings: [String] = []
  var notificationRequests: [UNNotificationRequest] = []
  // key is the String representation of the NotificationRequest, and the value is the String identifier of NR
  var notificationDictionary = [String: String]()

  override func viewDidLoad() {
    super.viewDidLoad()

    // Allow edit button to delete many rows at once
    //self.navigationItem.rightBarButtonItem = self.editButtonItem

    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.estimatedRowHeight = UITableView.automaticDimension

    self.title = "Scheduled Notifications"

    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false

    print("About to show some pending notifications, yo!")
    UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
      for request in requests {
        print(request)
        self.notificationRequestStrings.append(request.description)
        //self.notificationRequests.append(request)
        self.notificationDictionary[request.description] = request.identifier
      }
    })
  }

  // Helper Functions
  private func removePendingNotification(pendingRequestIdentifier: String) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [pendingRequestIdentifier])
  }


  // MARK: - Table view data source

/*
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
      return 1
  }
 */


  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // #warning Incomplete implementation, return the number of rows
      //return notificationRequestStrings.count
      return notificationDictionary.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath)

    //cell.textLabel?.text = notificationRequests[indexPath.row]
    let label = cell.viewWithTag(1000) as! UILabel

    label.text = notificationRequestStrings[indexPath.row]
    return cell
  }

  override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
     return UITableView.automaticDimension
  }


  // Override to support conditional editing of the table view.
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  // Override to support editing the table view.
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      // Delete the row from the data source
        let notificationString = notificationRequestStrings.remove(at: indexPath.row)

        if let notificationRequestIdentiferToRemove = notificationDictionary[notificationString] {
          removePendingNotification(pendingRequestIdentifier: notificationRequestIdentiferToRemove)
          notificationDictionary[notificationString] = nil
      }

        tableView.deleteRows(at: [indexPath], with: .fade)
      }


  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

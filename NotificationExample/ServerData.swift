//
//  ServerData.swift
//  NotificationExample
//
//  Created by Vui Nguyen on 9/19/18.
//  Copyright © 2018 Minitex. All rights reserved.
//

import Foundation

class ServerData {

  var lastServerCheck: Date = Date()
  var dueDate: Date = Date()
  let daysFromNow = 7
  let yearsFromNow = 0
  let monthsFromNow = 0

  func getServerData() {

  }

  func pollServer() -> Date {
    print("polling server")
    return dueDate
  }

  init() {
    calculateDueDate()
  }

  // let's set the due data to some days from now
  private func calculateDueDate() {
    let currentDate = Date()
    var dateComponents = DateComponents()
    dateComponents.year = yearsFromNow
    dateComponents.month = monthsFromNow
    dateComponents.day = daysFromNow

    dueDate = Calendar.current.date(byAdding: dateComponents, to: currentDate) ?? Date()
  }

  private func getLastPollingTime() {

  }

  func getPollingSchedule() {

  }
}

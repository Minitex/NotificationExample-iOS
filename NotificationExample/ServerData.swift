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
  var availabilityDate: Date?
  let daysFromNow = 7
  let monthsFromNow = 0
  let yearsFromNow = 0
  let minutes = 0
  let seconds = 0


  func pollServer() -> Date {
    print("polling server")
    return availabilityDate ?? calculateAvailabilityDate()
  }

  init() {
  }

  // let's set the due data to some days from now
  private func calculateAvailabilityDate() -> Date {
    let currentDate = Date()
    var dateComponents = DateComponents()
    dateComponents.year = yearsFromNow
    dateComponents.month = monthsFromNow
    dateComponents.day = daysFromNow

    availabilityDate = Calendar.current.date(byAdding: dateComponents, to: currentDate)
    return availabilityDate ?? Date()
  }

  func updateAvailabilityDate(updateDate: Date) -> Void {
    availabilityDate = updateDate

    // and then save to info.plist?
  }

  // from info.plist?
  private func getSavedAvailabilityDate() {

  }

  // from info.plist
  private func getLastPollingTime() {

  }

  func getPollingSchedule() {

  }
}

//
//  MemoriesApp.swift
//  Memories
//
//  Created by Spike on 1/5/2023.
//

import SwiftUI

@main
struct MemoriesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}


import ElegantCalendar

struct ExampleCalendarView: View {

    // Start & End date should be configured based on your needs.
    static let startDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (-30 * 36)))
    static let endDate = Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * (30 * 36)))

    @ObservedObject var calendarManager = ElegantCalendarManager(
        configuration: CalendarConfiguration(startDate: startDate,
                                             endDate: endDate))

    var body: some View {
        ElegantCalendarView(calendarManager: calendarManager)
    }

}

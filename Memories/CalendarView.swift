//
//  CalendarView_SwiftUI.swift
//  Memories
//
//  Created by Spike on 6/5/2023.
//

import SwiftUI
import Foundation
import UIKit

struct CalendarView: View {
    
    // 表示される月の任意の日に設定します（通常は1日）
    let monthToDisplay: Date
    
    init(monthToDisplay: Date) {
        self.monthToDisplay = monthToDisplay
    }
    
    @State private var selectedDay = Date()
    
    @State private var slideProgress: CGFloat = 0

    
    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let textWidth = (screenWidth - 48) / 7 // 7 是每行显示的天数
            let rowHeight: CGFloat = 3 * textWidth / 4 + 16 + 2 + 4

            
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(textWidth)), count: 7)) {
                    // Week day labels
                    ForEach(["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"], id: \.self) { weekdayName in
                        Text(weekdayName)
                            .font(.system(size: 16))
                    }
                    Spacer()
                    // Day number text
                    Section {
                        ForEach(monthToDisplay.getDaysForMonth(), id: \.self) { date in
                            // Only display days of the given month
                            if Calendar.current.isDate(date, equalTo: monthToDisplay, toGranularity: .month) {
                                let isSelected = Calendar.current.isDate(self.selectedDay, inSameDayAs: date)
                                let selectedWeekdayOrdinal = CGFloat(self.selectedDay.customWeekdayOrdinal())
                                let currentDateWeekdayOrdinal = CGFloat(date.customWeekdayOrdinal())
                                let offset = isSelected || currentDateWeekdayOrdinal == selectedWeekdayOrdinal ? -slideProgress * rowHeight * (selectedWeekdayOrdinal - 1) : 0
                                CalendarDayItem(day: date, textWidth: textWidth, selected: Calendar.current.isDate(self.selectedDay, inSameDayAs: Date()))
                                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.gray, lineWidth: Calendar.current.isDate(self.selectedDay, inSameDayAs: date) ? 2 : 0))
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .opacity(isSelected || currentDateWeekdayOrdinal == selectedWeekdayOrdinal || slideProgress == 0 ? 1 : 0)
                                    .offset(y: offset)
                                    .animation(.easeInOut(duration: isSelected ? 0.5 : 0), value: isSelected)
                                    .onTapGesture {
                                        self.selectedDay = date
                                    }
                            } else {
                                CalendarDayItem(day: date, textWidth: textWidth).hidden()
                            }
                        }
                    }
                }
                .gesture(
                    DragGesture()
                        .onEnded { value in
                            if value.translation.height < 0 {
                                withAnimation {
                                    slideProgress = 1
                                }
                            } else {
                                withAnimation {
                                    slideProgress = 0
                                }
                            }
                        }
                )

            
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: [CGFloat] = [0, 0]

    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value += nextValue()
    }
}

extension Date {
    
    func getDayNumber()->Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func getDaysForMonth() -> [Date] {
        guard
            let monthInterval = Calendar.current.dateInterval(of: .month, for: self),
            let monthFirstWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = Calendar.current.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else {
            return []
        }
        let resultDates = Calendar.current.generateDates(inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
                                                         matching: DateComponents(hour: 0, minute: 0, second: 0))
        return resultDates
    }
    
}

extension Date {
    func customWeekdayOrdinal() -> Int {
        var sundayFirstCalendar = Calendar(identifier: .gregorian)
        sundayFirstCalendar.firstWeekday = 1 // Set Sunday as the first day of the week
        let weekdayOrdinal = sundayFirstCalendar.component(.weekOfMonth, from: self)
        return weekdayOrdinal
    }
}




extension Calendar {
    
    func generateDates(inside interval: DateInterval, matching components: DateComponents) -> [Date] {
        var dates = [interval.start]
        enumerateDates(startingAfter: interval.start,
                       matching: components,
                       matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        return dates
    }
}
struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        let targetMonth = Calendar.current.date(byAdding: .month, value: 0, to: Date())
        CalendarView(monthToDisplay: targetMonth!)
    }
}

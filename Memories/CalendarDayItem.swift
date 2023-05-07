//
//  CalendarDayItem.swift
//  Memories
//
//  Created by Spike on 6/5/2023.
//

import SwiftUI

struct CalendarDayItem: View {
    
    let day: Date
    let textWidth: Double
    var selected: Bool = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        let isToday: Bool = Calendar.current.isDate(day, inSameDayAs: Date())
        VStack(spacing: 0) {
            Spacer(minLength: 2)
            Text("\(day.getDayNumber())")
                .font(isToday ? .system(size: 12).bold(): .system(size: 12))
                .frame(width: 16, height: 16)
                .padding(EdgeInsets(top: 2, leading: 1, bottom: 2, trailing: 1))
                .background(isToday ? self.colorScheme == .dark ? .white : .primary : .clear)
                .foregroundColor(isToday ? self.colorScheme == .dark ? .black : .white : .primary)
                .cornerRadius(7)
                .id(day)
            Rectangle().frame(width: textWidth, height: 3 * textWidth / 4).foregroundColor(self.colorScheme == .dark ? .black : .white)
        }
    }
}

struct CalendarDayItem_Previews: PreviewProvider {
    static var previews: some View {
        CalendarDayItem(day: Date(), textWidth: 30, selected: false)
//        let targetMonth = Calendar.current.date(byAdding: .month, value: 0, to: Date())
//        CalendarView(monthToDisplay: targetMonth!)

    }
}


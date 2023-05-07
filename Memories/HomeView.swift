//
//  HomeView.swift
//  Memories
//
//  Created by Spike on 6/5/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            
            if let targetMonth = Calendar.current.date(byAdding: .month, value: 0, to: Date()) {
                CalendarView(monthToDisplay: targetMonth)
            }
            Text("2023")
        }.padding(8)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

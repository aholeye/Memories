//
//  ContentView.swift
//  Memories
//
//  Created by Spike on 1/5/2023.
//
import SwiftUI

struct ContentView: View {
    let monthToDisplay = Date()

    var body: some View {
        GeometryReader { geometry in
            let screenWidth = geometry.size.width
            let textWidth = (screenWidth - 32) / 9 // 7 是每行显示的天数
            HStack(alignment: .top, spacing: 0) {
                ForEach(monthToDisplay.getDaysForMonth(), id: \.self) { date in
                    if Calendar.current.isDate(date, equalTo: monthToDisplay, toGranularity: .month) {
                        VStack {
                            Text("\(date.getDayNumber())")
                                .frame(width: textWidth)
                                .padding(8)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .id(date)
                            Spacer(minLength: 20) // 根据需要调整间隙大小
                        }
                    } else {
                        VStack {
                            Text("\(date.getDayNumber()))")
                                .hidden()
                            Spacer(minLength: 4) // 根据需要调整间隙大小
                        }
                    }
                }
            }.padding(.horizontal, 8) // 添加水平间距使 Text 与屏幕边缘保持一定的间距
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

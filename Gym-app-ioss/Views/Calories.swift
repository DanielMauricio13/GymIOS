//
//  Calories.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/13/24.
//

import SwiftUI

struct Calories: View {
    var mainUser: User?
     
    var body: some View {
        VStack {
            CircularProgressBar(progress: CaloriesManager.shared.calories, goal: mainUser?.DailyCalories ?? 1)
                    
                    let currentTime = Date()
                    let startOfDay = Calendar.current.startOfDay(for: currentTime)
                    let endOfDay = Calendar.current.date(byAdding: .hour, value: 24, to: startOfDay)!
                    
                   // LinearProgressBar(currentTime: currentTime, startOfDay: startOfDay, endOfDay: endOfDay)
                    
            Text("Your goal: \(CaloriesManager.shared.calories) / \(mainUser?.DailyCalories ?? 1)").font(.title).bold()
                }
        .padding()
            }
        
    }
struct LinearProgressBar: View {
    var currentTime: Date
    var startOfDay: Date
    var endOfDay: Date
    
    var progress: Double {
        let totalSeconds = endOfDay.timeIntervalSince(startOfDay)
        let elapsedSeconds = currentTime.timeIntervalSince(startOfDay)
        return min(elapsedSeconds / totalSeconds, 1.0)
    }
    
    var body: some View {
        VStack {
            Text("Today")
                .font(.headline)
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color.gray)
                    
                    Rectangle()
                        .frame(width: min(CGFloat(self.progress) * geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color.red)
                        
                }
                .cornerRadius(45.0)
            }
            .frame(height: 20)
        }
        .padding()
    }
}

struct CircularProgressBar: View {
    var progress: Int
    var goal: Int
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20.0)
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Double(progress) / Double(goal), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                
            
            Text(String(format: "%d%%", min(progress * 100 / goal, 100)))
                .font(.largeTitle)
                .bold()
        }
        .padding(40)
    }
}


struct CalorieCounter: View {
    var title: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            Text(title).foregroundStyle(Color.white)
            Spacer()
            Image(systemName: "flame").foregroundStyle(Color.orange)
            
            Spacer().frame(width: 14)
        }.frame(width:390, height: 50).background(Color.white.opacity(0.2)).clipShape(.capsule)
    }
}


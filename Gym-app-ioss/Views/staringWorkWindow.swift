//
//  staringWorkWindow.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/31/24.
//

import SwiftUI

struct staringWorkWindow: View {
     var todaysWork: workout_plans?
    @State private var timeRemaining = 5
       @State private var timerIsRunning = false
       let totalTime = 5
       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var exToday: String 
    @State var index = 0
    var cals:Int
    var body: some View {
        if timeRemaining == 0{
            VStack{
                Spacer()
                if index >= todaysWork?.exercises.count ?? 1 {
                   
                    Text("All Done!").font(.title3).italic().bold().foregroundStyle(Color.orange).font(.title2)
                    Text("You just burned \(cals) calories 🔥").font(.title2).italic().bold().foregroundStyle(Color.red)
                    
                    Button{
                        exToday = ""
                        
                    }label: {
                        Text("Go Back").foregroundStyle(Color.white).font(.title2).bold().background(Rectangle().clipShape(.buttonBorder).frame(width: 100,height: 40)).padding(.top)
                    }
                      
                }else{
                    Text("Your exercise \(index) is \(todaysWork?.exercises[index].name ?? "PullUps")")
                    
                }
                Spacer()
            }
        }
        else{
            VStack {
                Spacer()
                ZStack {
                    CircularProgressView(progress: Double(totalTime - timeRemaining) / Double(totalTime))
                        .frame(width: 200, height: 200)
                    Text("\(timeRemaining)")
                        .font(.system(size: 100, weight: .bold, design: .monospaced))
                        .foregroundColor(timeRemaining > 3 ? .green : timeRemaining > 1 ? .yellow : .red)
                        .scaleEffect(timerIsRunning && timeRemaining > 0 ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.5), value: timeRemaining)
                }
                .padding()
                Spacer()
            }.onAppear{
                self.timeRemaining = totalTime
                self.timerIsRunning = true           }
            .onReceive(timer) { _ in
                if self.timerIsRunning && self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
        }
       }
}


struct CircularProgressView: View {
    var progress: Double
    var lineWidth: CGFloat = 10
    var color: Color = .blue

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear(duration: 0.5), value: progress)
        }
    }
}



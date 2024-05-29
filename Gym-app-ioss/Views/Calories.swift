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
                Text("Todays Nutrition").font(.largeTitle).bold()
                HStack{
                    Spacer()
                    VStack(alignment: .center) {
                        CircularProgressBar(progress: CaloriesManager.shared.calories, goal: mainUser?.DailyCalories ?? 1)
                        Text("Your Calories goal: \(CaloriesManager.shared.calories) / \(mainUser?.DailyCalories ?? 1) 🔥").font(.title3)
                        Spacer()
                    }.frame(width: 200,height: 300)
                    Spacer()
                    VStack(alignment: .center){
                        CircularProgressBar(progress: ProteinManager.shared.protein, goal: mainUser?.DailyProtein ?? 1)
                        Text("Your Protein goal: \(ProteinManager.shared.protein) / \(mainUser?.DailyProtein ?? 1) 🍗").font(.title3)
                        Spacer()
                    }.frame(width: 200,height: 300)
                    Spacer()
                }
                HStack{
                    Spacer()
                    VStack(alignment: .center) {
                        CircularProgressBar(progress: CaloriesManager.shared.calories, goal: mainUser?.DailyCalories ?? 1)
                        Text("Your Sugar goal: \(CaloriesManager.shared.calories) / \(mainUser?.sugars ?? 1) ").font(.title3)
                        Spacer()
                    }.frame(width: 200,height: 300)
                    Spacer()
                    VStack(alignment: .center){
                        CircularProgressBar(progress: ProteinManager.shared.protein, goal: mainUser?.DailyProtein ?? 1)
                        Text("Your Water goal: \(ProteinManager.shared.protein) / \(mainUser?.water ?? 1) 🍗").font(.title3)
                        Spacer()
                    }.frame(width: 200,height: 300)
                    Spacer()
                }
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
                .frame(width: 150, height: 150) // Adjust the frame size
                .opacity(0.3)
                .foregroundColor(Color.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(Double(progress) / Double(goal), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .round))
                .frame(width: 150, height: 150) // Adjust the frame size
                .foregroundColor(Color.red)
                .rotationEffect(Angle(degrees: 270.0))
                
            
            Text(String(format: "%d%%", min(progress * 100 / goal, 100)))
                .font(.title2)
                .bold()
        }
        .padding(40)
    }
}





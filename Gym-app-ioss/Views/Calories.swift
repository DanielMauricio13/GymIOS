//
//  Calories.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/13/24.
//

import SwiftUI

struct Calories: View {
    
    @Binding var caloriesToday: Int
    var body: some View {
        Text("Your Calories Today \(caloriesToday)").font(.largeTitle)
        
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


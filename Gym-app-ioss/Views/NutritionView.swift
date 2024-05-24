//
//  NutritionView.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/8/24.
//

import SwiftUI

struct NutritionView: View {
    
    @State var foods: [Food]?
    var body: some View {
        HStack{
            Spacer().frame(width: 20)
            Text("Today you had: ").font(.title).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/).italic()
            Spacer()
            Button(action: {
                        // Add action for button tap
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.title)
                            .frame(width: 50, height: 80)
                            .background(Color.red)
                            .clipShape(Circle())
                    }
            Spacer().frame(width: 20)
        }
        Spacer()
        
        ScrollView{
            ListItem(title: "Chicken")
            ListItem(title: "Steak")
            ListItem(title: "Shrimp")
        }
        
    }
}

struct ListItem: View {
    var title: String
    
    var body: some View {
        HStack {
            Spacer().frame(width: 20)
            Text(title).foregroundStyle(Color.white)
            Spacer()
            Image(systemName: "flame").foregroundStyle(Color.red)
            
            Spacer().frame(width: 14)
        }.frame(width:390, height: 50).background(Color.white.opacity(0.2)).clipShape(.capsule)
    }
}

#Preview {
    NutritionView()
}

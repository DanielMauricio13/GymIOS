//
//  MainWindow2.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 9/29/23.
//

import SwiftUI

struct MainWindow2: View {
 var mainUser:User?
    
    
    var userFullWork: fullTraining?
    @State var buttomPressed:Bool = false
    
    
    var body: some View {
        if buttomPressed {
            ExcerciseWindow(mainUser: mainUser,userFullWork: self.userFullWork)
        }
        else{ ZStack {
            Color.black.edgesIgnoringSafeArea(.all) // Set background color to black
                        
            VStack {
                
                Text("Welcome \(mainUser?.firstName ?? "User")")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .shadow(color: .white, radius: 20)
                Spacer().frame(height: 150)
                Button{
                    buttomPressed=true
                }
            label:{
                (Text("Begin")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(.white)
                    .frame(width: 150, height: 70)
                    .background(Color.red)
                    .cornerRadius(10)
                )
            }
                Spacer().frame(height:60)
                
                
                
            }
        }
        }
           
    }
    

    
}

#Preview {
    MainWindow2()
}

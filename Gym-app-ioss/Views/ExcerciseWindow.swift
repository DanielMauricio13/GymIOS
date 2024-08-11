//
//  ExcerciseWindow.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/8/24.
//

import SwiftUI

 
struct ExcerciseWindow: View {
    
    var mainUser: User?
    @State var whichWin: Int = 0
    @State var caloriesToday: Int = 0
    var userFullWork: fullTraining?
    @State var persistenceManager = PersistenceManager()
    @State var LogOut: Bool = false
    @State var exToday: String = ""
    @State var counts: Int?
    var body: some View {
        if LogOut {
            LogInWindow()
        }
        
        // Your main content here
        else{
            NavigationView {
                VStack {
            
                    if (exToday != "" && whichWin == 0){
                        WorkOutWindow(mainUser: self.mainUser, userFullWork: self.userFullWork, exToday: $exToday)
                    }
                    else if( whichWin == 0 ){
                        FisrtWindow(mainUser: self.mainUser,userFullWork: self.userFullWork, viewModel: ListViewModel(items: []), viewModel2: ListViewModel(items: []), exToday: $exToday  )
                    }
                    else if(whichWin == 1){
                        NutritionView( viewModel: ListViewModel(items: []), viewModel2: ListViewModel(items: []), persistenceManager: $persistenceManager)
                    }
                    else if(whichWin == 2){
                        Calories(mainUser: mainUser)
                    }
                    else if (whichWin == 3){
                        UserSettings(persistenceManager: $persistenceManager, LogOut: $LogOut)
                    }
                    Spacer()
                    
                    // Sticky navigation bar
                    HStack {
                        Spacer()
                        Button(action: {whichWin = 0}) {
                            Image(systemName: "house")
                                .padding()
                                .foregroundColor(whichWin == 0 ? Color .red :Color.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        Button(action: {whichWin = 1}) {
                            Image(systemName: "leaf")
                                .padding()
                                .foregroundColor(whichWin == 1 ? Color .red :Color.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        Button(action: {whichWin = 2}) {
                            Image(systemName: "flame")
                                .padding()
                                .foregroundColor(whichWin == 2 ? Color .red :Color.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        Spacer()
                        
                        
                        
                        Button(action: {
                            whichWin = 3
                        }) {
                            Image(systemName: "gear")
                                .padding()
                                .foregroundColor(whichWin == 3 ? Color .red :Color.white)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        
                        
                        Spacer()
                        
                    }
                    .padding()
                    .frame(height: 70) // Adjust the height of the navigation bar as needed
                    .background(Color.red)
                    .edgesIgnoringSafeArea(.bottom) // Extend the navigation bar to the bottom
                }
                .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)) // Background color for the main content
                .navigationBarHidden(true) // Hide the default navigation bar
            }.onAppear{
                counts = userFullWork?.userExcersises.workout_plan.count
            }
        }
            }
  

    
}
#Preview {
    ExcerciseWindow()
}

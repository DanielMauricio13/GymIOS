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
    
    var userFullWork: fullTraining?
    
    @State var counts: Int?
    var body: some View {
    
        
             
        
        // Your main content here
        
        NavigationView {
                    VStack {
                        // Your main content
                       
                        
                        // Spacer to push navigation bar to the bottom
                        
                        if( whichWin == 0 ){
                            FisrtWindow(mainUser: self.mainUser,userFullWork: self.userFullWork, viewModel: ListViewModel(items: []), viewModel2: ListViewModel(items: [])  )
                        }
                            else if(whichWin == 1){
                                NutritionView( viewModel: ListViewModel(items: []), viewModel2: ListViewModel(items: []))
                            }
                        else if (whichWin == 3){
                                UserSettings()
                        }
                        Spacer()
                        
                        // Sticky navigation bar
                        HStack {
                            Spacer()
                            Button(action: {whichWin = 0}) {
                                Image(systemName: "house")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                            Button(action: {whichWin = 1}) {
                                Image(systemName: "leaf")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                            Button(action: {}) {
                                Image(systemName: "flame")
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.black)
                                    .cornerRadius(10)
                            }
                            
                            Spacer()
                           
                         
                               
                                    Button(action: {
                                        whichWin = 3
                                            logout()
                                    }) {
                                        Image(systemName: "gear")
                                            .padding()
                                            .foregroundColor(.white)
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
    func logout()->Void {
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "username")
    }

    
}
#Preview {
    ExcerciseWindow()
}

//
//  UserSettings.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/13/24.
//

import SwiftUI

struct UserSettings: View {
    @Binding  var persistenceManager: PersistenceManager
    @Binding var LogOut: Bool
    var body: some View {
        VStack{
            Text("User Settings").font(.largeTitle).foregroundStyle(Color.white)
            Spacer()
            Button{
                logout()
                LogOut = true
            }label: {
                Text("Log out").font(.title3).foregroundStyle(Color.white).background(RoundedRectangle(cornerRadius: 90).foregroundStyle(Color.red).frame(width: 150, height: 50) )
            }
            
        }
    }
    func logout()->Void {
        UserDefaults.standard.removeObject(forKey: "isAuthenticated")
        UserDefaults.standard.removeObject(forKey: "username")
        CaloriesManager.shared.calories = 0
        ProteinManager.shared.protein = 0
        persistenceManager.clearItems()
    }
    
      
    
}


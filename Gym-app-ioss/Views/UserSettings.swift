//
//  UserSettings.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/13/24.
//

import SwiftUI

struct UserSettings: View {
    @State private var shouldNavigate = false
    var body: some View {
        
        NavigationLink("Log out") {
            LogInWindow()
        }
    }
    
      
    
}

#Preview {
    UserSettings()
}

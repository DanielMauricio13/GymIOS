//
//  PersiatnceCalories.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/25/24.
//

import Foundation


extension UserDefaults {
    private enum Keys {
        static let calories = "calories"
        static let lastResetDate = "lastResetDate"
    }

    var calories: Int {
        get {
            return integer(forKey: Keys.calories)
        }
        set {
            set(newValue, forKey: Keys.calories)
        }
    }

    var lastResetDate: Date? {
        get {
            return object(forKey: Keys.lastResetDate) as? Date
        }
        set {
            set(newValue, forKey: Keys.lastResetDate)
        }
    }
}

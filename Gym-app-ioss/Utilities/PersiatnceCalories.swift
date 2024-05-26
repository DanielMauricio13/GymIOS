//
//  PersiatnceCalories.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/25/24.
//

import Foundation


extension UserDefaults {
    private enum Keys {
        static let caloriesToday = "caloriesToday"
        static let lastResetDate = "lastResetDate"
    }

    var calories: Int {
        get {
            return integer(forKey: Keys.caloriesToday)
        }
        set {
            set(newValue, forKey: Keys.caloriesToday)
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


class CaloriesManager {
    static let shared = CaloriesManager()

    var calories: Int {
        get {
            return UserDefaults.standard.calories
        }
        set {
            UserDefaults.standard.calories = newValue
        }
    }

    private init() {
        // Check if the last reset date was today; if not, reset calories
        if let lastResetDate = UserDefaults.standard.lastResetDate,
           !Calendar.current.isDateInToday(lastResetDate) {
            self.calories = 0
        }
        
        // Set the last reset date to today
        UserDefaults.standard.lastResetDate = Date()
        
        // Schedule the reset at midnight
        scheduleMidnightReset()
    }

    private func scheduleMidnightReset() {
        let now = Date()
        let calendar = Calendar.current

        // Calculate the next midnight
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = 0
        components.minute = 0
        components.second = 0

        guard let nextMidnight = calendar.date(byAdding: .day, value: 1, to: calendar.date(from: components)!) else {
            return
        }

        // Schedule the reset
        let timeInterval = nextMidnight.timeIntervalSince(now)
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            self.resetCalories()
        }
    }

    private func resetCalories() {
        self.calories = 0
        UserDefaults.standard.calories = 0
        UserDefaults.standard.lastResetDate = Date()
        
        // Reschedule the reset for the next midnight
        scheduleMidnightReset()
    }
}

extension UserDefaults {
    private enum Keyss {
        static let protein = "protein"
        static let lastResetDate = "lastResetDate"
    }

    var protein: Int {
        get {
            return integer(forKey: Keyss.protein)
        }
        set {
            set(newValue, forKey: Keyss.protein)
        }
    }

    var lastResetDatee: Date? {
        get {
            return object(forKey: Keyss.lastResetDate) as? Date
        }
        set {
            set(newValue, forKey: Keyss.lastResetDate)
        }
    }
}



class ProteinManager {
    static let shared = ProteinManager()

    var protein: Int {
        get {
            return UserDefaults.standard.protein
        }
        set {
            UserDefaults.standard.protein = newValue
        }
    }

    private init() {
        // Check if the last reset date was today; if not, reset protein
        if let lastResetDate = UserDefaults.standard.lastResetDate,
           !Calendar.current.isDateInToday(lastResetDate) {
            self.protein = 0
        }
        
        // Set the last reset date to today
        UserDefaults.standard.lastResetDate = Date()
        
        // Schedule the reset at midnight
        scheduleMidnightReset()
    }

    private func scheduleMidnightReset() {
        let now = Date()
        let calendar = Calendar.current

        // Calculate the next midnight
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        components.hour = 0
        components.minute = 0
        components.second = 0

        guard let nextMidnight = calendar.date(byAdding: .day, value: 1, to: calendar.date(from: components)!) else {
            return
        }

        // Schedule the reset
        let timeInterval = nextMidnight.timeIntervalSince(now)
        Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            self.resetProtein()
        }
    }

    private func resetProtein() {
        self.protein = 0
        UserDefaults.standard.protein = 0
        UserDefaults.standard.lastResetDate = Date()
        
        // Reschedule the reset for the next midnight
        scheduleMidnightReset()
    }
}


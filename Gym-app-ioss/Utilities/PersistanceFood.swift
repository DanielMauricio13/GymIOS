//
//  PersistanceFood.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/24/24.
//

import Foundation

class PersistenceManager {
    private let userDefaults = UserDefaults.standard
    private let itemsKey = "items"
    private let dateKey = "saveDate"

    func saveItems(items: [Food]) {
        let encoder = JSONEncoder()
        if let encodedItems = try? encoder.encode(items) {
            userDefaults.set(encodedItems, forKey: itemsKey)
            userDefaults.set(Date(), forKey: dateKey)
        }
    }

    func loadItems() -> [Food] {
        guard let savedDate = userDefaults.object(forKey: dateKey) as? Date else { return [] }
        let oneDayAgo = Date().addingTimeInterval(-86400)
        
        if savedDate < oneDayAgo {
            clearItems()
            return []
        }
        
        if let savedItems = userDefaults.data(forKey: itemsKey) {
            let decoder = JSONDecoder()
            if let loadedItems = try? decoder.decode([Food].self, from: savedItems) {
                return loadedItems
            }
        }
        return []
    }

    private func clearItems() {
        userDefaults.removeObject(forKey: itemsKey)
        userDefaults.removeObject(forKey: dateKey)
    }
}

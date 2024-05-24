//
//  Food.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/8/24.
//

import Foundation

struct Food:Codable {
    var id: UUID?
    let Name:String
    let Calories: Int
    let Sugars: Int
    let Carbohydrates:Int
    let Protein: Int
}

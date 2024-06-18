//
//  TimeTrackingAttributes.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 6/13/24.
//

import Foundation
import ActivityKit

struct TimerAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var timeRemaining: Int
    }
    
    var totalTime: Int
}

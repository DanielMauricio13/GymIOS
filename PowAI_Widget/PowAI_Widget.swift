//
//  PowAI_Widget.swift
//  PowAI_Widget
//
//  Created by Daniel Pinilla on 6/16/24.
//
import WidgetKit
import SwiftUI
import ActivityKit




struct PowAI_Widget: Widget {
    
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimeTrackingAttributes.self) { context in
            TimerLockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded view
                DynamicIslandExpandedRegion(.trailing) {
                    HStack {
                        Text("Start Time:").bold().font(.title2)
                        Text(context.state.startTime, style: .timer)
                            .bold()
                            .font(.title2)
                            .foregroundColor(.accentColor) // Example of adding color
                        
                    }
                }
                DynamicIslandExpandedRegion(.leading){
                    Text("hey").font(.title)
                }
            } compactLeading: {
                HStack{
                    
                    Text(context.state.startTime,style: .timer)
                    //Text("Set: \(context.state.startTime.timeIntervalSince())")
                    
                    Spacer()
                }
            } compactTrailing: {
//                Text("yg")
//                Text(context.state.startTime, style: .timer).contentMargins(0.2)
//                    .bold()
//                    .font(.title3)
//                    .foregroundColor(.primary)
//                    .padding(1)
            } minimal: {
                
                Text(context.state.startTime, style: .timer)
                    .bold()
                    .font(.caption)
                    .foregroundColor(.accentColor)
            }
        }
    }
    func getTat(dta: Date)-> String {
       // let date = dta
        //let calendar = Calendar.current
       
        
        return ""
    }
    
}



struct TimerLockScreenView: View {
    let context: ActivityViewContext<TimeTrackingAttributes>

    var body: some View {
        HStack{
            Spacer(minLength: 20)
            Text("Set: \(context.state.set)").font(.title)
                .bold()
                .foregroundColor(.red) // Example of adding color
            Spacer(minLength: 20)
            Text(context.state.startTime, style: .timer)
                .font(.title)
                .bold()
                .foregroundColor(.accentColor) // Example of adding color
        }
    }
}


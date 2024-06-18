//
//  PowAI_Widget.swift
//  PowAI_Widget
//
//  Created by Daniel Pinilla on 6/16/24.
//
import WidgetKit
import SwiftUI
import ActivityKit




struct  PowAI_Widget: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: TimerAttributes.self) { context in
            // Lock screen/banner presentation
            TimerLockScreenView(context: context)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded view
                
                DynamicIslandExpandedRegion(.bottom) {
                    HStack{
                        Text("Recovery Time Remaining ").bold().font(.title2)
                        Text("\(context.state.timeRemaining)").bold().foregroundColor(context.state.timeRemaining > 30 ? .green : context.state.timeRemaining > 20 ? .yellow : context.state.timeRemaining > 10 ? .orange : .red)
                    }
                    
                }
               
            } compactLeading: {
                Text("TR")
            } compactTrailing: {
                Text("\(context.state.timeRemaining)").bold().foregroundColor(context.state.timeRemaining > 30 ? .green : context.state.timeRemaining > 20 ? .yellow : context.state.timeRemaining > 10 ? .orange : .red)
            } minimal: {
                Text("\(context.state.timeRemaining)").bold().foregroundColor(context.state.timeRemaining > 30 ? .green : context.state.timeRemaining > 20 ? .yellow : context.state.timeRemaining > 10 ? .orange : .red)
            }
        }
    }
}

struct TimerLockScreenView: View {
    let context: ActivityViewContext<TimerAttributes>

    var body: some View {
        VStack {
            Text("Recovery Time Remaining").font(.title).bold()
            Text("\(context.state.timeRemaining)")
                .font(.largeTitle).foregroundColor(context.state.timeRemaining > 30 ? .green : context.state.timeRemaining > 20 ? .yellow : context.state.timeRemaining > 10 ? .orange : .red)
        }
        .padding()
    }
}

//
//  staringWorkWindow.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 5/31/24.
//

import SwiftUI

struct staringWorkWindow: View {
     var todaysWork: workout_plans?
    @State private var timeRemaining = 5
       @State private var timerIsRunning = false
    @State private var timeRemaining2 = 60
       @State private var timerIsRunning2 = false
      @State var totalTime = 5
    @State var totalTime2 = 60
       let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    let timer2 = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Binding var exToday: String
    @State var index = 0
    @State var set = 1
    var cals:Int
    @State var buttonPressed = false
    var body: some View {
        if timeRemaining == 0 || index >= todaysWork?.exercises.count ?? 1{
            VStack{
                
                if index >= todaysWork?.exercises.count ?? 1 {
                    Spacer()
                    Text("All Done!").font(.title3).italic().bold().foregroundStyle(Color.orange).font(.title2)
                    Text("You just burned \(cals) calories 🔥").font(.title2).italic().bold().foregroundStyle(Color.red)
                    
                    Button{
                        exToday = ""
                        
                    }label: {
                        Text("Go Back").foregroundStyle(Color.white).font(.title2).bold().background(Rectangle().clipShape(.buttonBorder).frame(width: 100,height: 40)).padding(.top)
                    }
                      
                }else{
                    Text("\(todaysWork?.exercises[index].name ?? "PullUps")").font(.largeTitle).italic().bold().foregroundStyle(Color.white)
                    
                    ImageView(imageURL: "https://gym-app-api-38b971084be9.herokuapp.com/images/imageName?name=\(todaysWork?.exercises[index].name ?? "bad").jpeg")
                                    .frame(width: 400, height: 300)
                    if buttonPressed == false || timeRemaining2 == 0{
                        HStack{
                            Text("Set \(set):").font(.title).padding(.leading).padding(.top).foregroundStyle(Color.white).bold()
                            Spacer()
                            
                        }
                        Text("Reps \(todaysWork?.exercises[index].reps ?? "1")").font(.title).padding(.leading).padding(.top).foregroundStyle(Color.white).bold()
                        Button{
                            set += 1
                            if(set > todaysWork?.exercises[index].sets ?? 4){
                                index += 1
                                totalTime = 5
                                timeRemaining = 5
                                set = 1
                            }else{
                                
                                buttonPressed = true
                            }
                            
                        }label: {
                            Text("Finish Set").foregroundStyle(Color.white).font(.title2).bold().background(Rectangle().clipShape(.buttonBorder).frame(width: 100,height: 40)).padding(.top)
                        }.onAppear{
                            buttonPressed = false
                            timeRemaining2 = 60
                            totalTime2 = 60
                        }
                    }else{
                        VStack {
                            Spacer()
                            ZStack {
                                CircularProgressView(progress: Double(totalTime2 - timeRemaining2) / Double(totalTime2))
                                    .frame(width: 200, height: 200)
                                Text("\(timeRemaining2)")
                                    .font(.system(size: 100, weight: .bold, design: .monospaced))
                                    .foregroundColor(timeRemaining2 > 30 ? .green : timeRemaining2 > 20 ? .yellow: timeRemaining2 > 10 ? .orange : .red)
                                    .scaleEffect(timerIsRunning2 && timeRemaining2 > 0 ? 1.2 : 1.0)
                                    .animation(.easeInOut(duration: 0.5), value: timeRemaining2)
                            }
                            .padding()
                            Spacer()
                        }.onAppear{
                            
                            
                            self.timeRemaining2 = totalTime2
                            self.timerIsRunning2 = true           }
                        .onReceive(timer2) { _ in
                            if self.timerIsRunning2 && self.timeRemaining2 > 0 {
                                self.timeRemaining2 -= 1
                            }
                        }
                    }
                }
                Spacer()
            }
        }
        else{
            VStack {
                Spacer()
                Text("Get Ready!\nNext Exercise is \(todaysWork?.exercises[index].name ?? "pushdowns")").font(.title).foregroundStyle(Color.white).padding(.bottom)
                ZStack {
                    CircularProgressView(progress: Double(totalTime - timeRemaining) / Double(totalTime))
                        .frame(width: 200, height: 200)
                    Text("\(timeRemaining)")
                        .font(.system(size: 100, weight: .bold, design: .monospaced))
                        .foregroundColor(timeRemaining > 3 ? .green : timeRemaining > 2 ? .yellow : .red)
                        .scaleEffect(timerIsRunning && timeRemaining > 0 ? 1.2 : 1.0)
                        .animation(.easeInOut(duration: 0.5), value: timeRemaining)
                }
                .padding()
                Spacer()
            }.onAppear{
                
                
                self.timeRemaining = totalTime
                self.timerIsRunning = true           }
            .onReceive(timer) { _ in
                if self.timerIsRunning && self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                }
            }
        }
       }
    struct ImageView: View {
        let imageURL: String // The URL of the image

        var body: some View {
            AsyncImage(url: URL(string: imageURL)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else if phase.error != nil {
                    Text("Failed to load image")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 400, height: 300)
        }
    }
}


struct CircularProgressView: View {
    var progress: Double
    var lineWidth: CGFloat = 10
    var color: Color = .blue

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: lineWidth)
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear(duration: 0.5), value: progress)
        }
    }
}




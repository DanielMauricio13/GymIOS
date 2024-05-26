//
//  questionaire.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 8/15/23.
//

import SwiftUI

struct questionaire: View {
    @State private var questions: [Question] = [
        Question(text: "What is your body Type?", options: ["Ectomorph", "Mesomorph", "Endomorph"], imageName: "cat" ),
            Question(text: "What is your objective?", options: ["Increase mass", "Stay fit", "Lose weight"], imageName: "cat"),
            Question(text: "Genetic gender?", options: ["Male", "Female"], imageName: "cat"),
            Question(text: "How many days do you want to work per week?" , options: ["1", "2", "3", "4", "5" ], imageName: "cat"),
            Question(text: "how many hours per day do you want to work?", options: ["less than 1 hour", "1 hour to 2 hours", "more than 2 hours"], imageName: "cat")
        ]
    @State private var currentQuestionIndex = 0
    
    let firstName: String
    let lastName:String
    var age: Int = 0
    @State var gender: String = ""
    var weight: Int = 0
   @State var goal: String = ""
   @State var bodyStructure: String = "ss"
    var height: Int = 0
    var DailyCalories: Int  = 0
    var DailyProtein: Int  = 0
    var email:String
    var password: String
    @State var numDays = ""
    @State var workoutHours = ""
    @State var nextPage:Bool = false
    @State var numDaysw: String = ""
    @State var numHours: String = ""
    var body: some View {
        
        NavigationView {
            ZStack{
                Color.black.ignoresSafeArea()
                VStack {
                  
                    
                    if currentQuestionIndex < questions.count {
                        Text("Building your plan!").font(.largeTitle).bold().foregroundColor(.white).padding(.bottom,100)
                        if currentQuestionIndex == 0 {
                            Image("Body-Set") // Replace with the actual name of your image
                                            .resizable() // Makes the image resizable
                                            .aspectRatio(contentMode: .fit) // Maintains the aspect ratio
                                            .frame(width: 300, height: 200) // Sets the frame size
                                            .clipShape(Rectangle()) // Optionally clips the image to a circle
                                            .overlay(
                                                Rectangle().stroke(Color.white, lineWidth: 1) // Adds a border to the image
                                            )
                                            .shadow(radius: 10)
                        }
                        QuestionView(question: $questions[currentQuestionIndex], nextQuestion: nextQuestion)
                        
                    } else {
                        if let numDaysInt = Int(questions[3].selectedOption) {
                            finalData(firstName: firstName,
                                      lastName: lastName,
                                      gender: questions[2].selectedOption,
                                      goal: questions[1].selectedOption,
                                      bodyStructure: questions[0].selectedOption,
                                      email: email,
                                      password: password,
                                      numDays: numDaysInt,
                                      numHours: questions[4].selectedOption)
                        } else {
                            
                        }
                        
                        
                    }
                }
            }
        }
    
    }
    func nextQuestion() {
            currentQuestionIndex += 1
        }
    
    
   
    
}

struct questionaire_Previews: PreviewProvider {
    static var previews: some View {
        questionaire(firstName: "daniel", lastName: "p", email: "oakdd", password: "kdkasdkla")
    }
}


struct Question: Hashable {
    var text: String
    var options: [String]
    var selectedOption: String = ""
    var imageName: String // Name of the image
}

struct QuestionView: View {
    @Binding var question: Question
    var nextQuestion: () -> Void
    
    var body: some View {
        
            
        VStack {
            Text(question.text)
                .font(.title)
                .padding(.bottom,300).foregroundColor(.white)
            
            HStack{
            ForEach(question.options, id: \.self) { option in
                Button(action: {
                    question.selectedOption = option // Store the selected option
                    nextQuestion()
                }) {
                    Text(option)
                        .font(.headline)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)
            }
        }
            }.navigationBarBackButtonHidden()
                .padding()
        
    }
}

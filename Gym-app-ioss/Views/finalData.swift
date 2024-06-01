//
//  finalData.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 8/15/23.
//

import SwiftUI
import GoogleGenerativeAI

struct finalData: View {
    let firstName: String
    let lastName:String
    @State var age: Int = 0
    var gender: String
    @State var weight: Int = 0
    var goal: String
    var bodyStructure: String
    @State var height: Int = 0
    @State var DailyCalories:Int = 0
   @State var DailyProtein: Int = 0
    var email:String
    @State private var isNavigationActive: Bool = false
    let password: String
    @State var submit: Bool = false
    let numDays: Int
    let numHours: String
    @State var prompt: String?
    let model = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default)
    @State var excersise: userExcersise?
    @State var responseInString: String = "valve"
    @State private var selectedOption = "Kg"
    @State private var selectedOption2 = "cm"
    let options = ["Kg", "lb"]
    let optionsw = ["cm", "Ft + in"]
    @State var heightFt: Int = 0
    @State var heightIn: Int = 0
    @State var carbs :Int?
    @State var sugars: Int?
    @State var DalyCaloriesBurn: Int?
    var whereWork : String
    
    @State var water: Double?
    
    var body: some View {
    
        if submit{
            
            LogInWindow().navigationBarBackButtonHidden()
        }
        else{
            VStack{
                Text("Final data").font(.title).foregroundColor(.white).bold()
                Spacer()
                VStack{
                    Form{
                        Section(header: Text("Age").foregroundColor(.red)){
                            TextField("Age", text: Binding<String>(
                                get: { String() },
                                set: { if let newValue = Int($0) { age = newValue } }
                            )).keyboardType(.numberPad).listRowBackground(Color.gray)
                        }.foregroundColor(.white).bold()
                        Section(header: Text("Height").foregroundStyle(Color.red)){
                            HStack{
                                if(selectedOption2 == "cm"){
                                    TextField("Height", text: Binding<String>(
                                        get: { String() },
                                        set: { if let newValue = Int($0) { height = newValue } }
                                    )).keyboardType(.numberPad).listRowBackground(Color.gray)
                                }else{
                                    TextField("Ft", text: Binding<String>(
                                        get: { String() },
                                        set: { if let newValue = Int($0) { heightFt = newValue } }
                                    )).keyboardType(.numberPad).listRowBackground(Color.gray)
                                    TextField("in", text: Binding<String>(
                                        get: { String() },
                                        set: { if let newValue = Int($0) { heightIn = newValue } }
                                    )).keyboardType(.numberPad).listRowBackground(Color.gray)
                                }
                                Picker("", selection: $selectedOption2) {
                                    ForEach(optionsw, id: \.self) { option in
                                        Text(option)
                                    }
                                    
                                }
                                .pickerStyle(MenuPickerStyle())
                            }
                          
                        }.foregroundColor(.white).bold().listRowBackground(Color.gray)
                        Section(header: Text("Weight ").foregroundStyle(Color.red)){
                            HStack{
                                TextField("Weight", text: Binding<String>(
                                    get: { String() },
                                    set: { if let newValue = Int($0) { weight = newValue } }
                                )).keyboardType(.numberPad).listRowBackground(Color.gray)
                                Picker("", selection: $selectedOption) {
                                    ForEach(options, id: \.self) { option in
                                        Text(option)
                                    }
                                    
                                }
                                .pickerStyle(MenuPickerStyle()) // Dropdown style
                            }
                            
                            
                        }.foregroundColor(.white).bold().listRowBackground(Color.gray)
                       
                    }
                    
//                    Button{
//                        Task{ try await submitData()}
//                    }label: {
//                        Text("Create account \(firstName)").foregroundColor(.white).font(.title)
//                    }
                    Button{
                        Task{ try await geminii()}
                    }label: {
                        Text("Create account \(firstName)").foregroundColor(.white).font(.title)
                    }
                    
                }
            }
        }
    }
    
   
    
    func geminii() async throws {
        
        let config = GenerationConfig(
            temperature: 1,
            topP: 0.95,
            topK: 64,
            maxOutputTokens: 8192,
            responseMIMEType: "text/plain"
        )
        
        // Don't check your API key into source control!
        let apiKey = "AIzaSyD_X7ymdkDp0goekMxVfD3lOsO1yTGSgkU"
        
        
        let model = GenerativeModel(
            name: "gemini-1.5-flash-latest",
            apiKey: apiKey,
            generationConfig: config,
            safetySettings: [
                SafetySetting(harmCategory: .harassment, threshold: .blockMediumAndAbove),
                SafetySetting(harmCategory: .hateSpeech, threshold: .blockMediumAndAbove),
                SafetySetting(harmCategory: .sexuallyExplicit, threshold: .blockMediumAndAbove),
                SafetySetting(harmCategory: .dangerousContent, threshold: .blockMediumAndAbove)
            ]
        )
        
       
        
        
        
            let message1 = "a \(gender) of \(age) years with a height of \(height) \(selectedOption2) and a weigth of \(weight) \(selectedOption) with a body structure of \(bodyStructure) wants to \(goal), in a Json file give me the exact number(not in range)  of Protein (in an Int), Calories(in an Int), sugars(in an Int), and Carbs(in an Int), BurnCalories (that that person needs to burn daily, in an int), and water(in a Double)  a day that person should consume to fulfill his goal. Do not include Important Considerations"
            let message2 = "a \(gender) of \(age) years with a height of \(height) \(selectedOption2) and a weight of \(weight) \(selectedOption) with a body structure of \(bodyStructure) wants to \(goal) working out at \(whereWork), in a Json file give me a list of excercises to train every muscule and divide them in \(numDays) days so each muscule can be trained in their own dedicated day and have in mind that the person wants to workout for \(numHours) hours. The format should be: day number it corresponds to, name of the excersise( in string) , repetitions(in string), number of series(an Int) and the approx calories burned (an Int). Ignore recomendations!"
       
            let message3 = "a \(gender) of \(age) years with a height of \(heightFt),\(heightIn)  \(selectedOption2) and a weigth of \(weight) \(selectedOption) with a body structure of \(bodyStructure) wants to \(goal), in a Json file give me the exact number(not in range)  of Protein (in an Int), Calories(in an Int), sugars(in an Int), and Carbs(in an Int), BurnCalories (that that person needs to burn daily, in an int), and water(in a Double)  a day that person should consume to fulfill his goal. Do not include Important Considerations"
            let message4 = "a \(gender) of \(age) years with a height of \(heightFt),\(heightIn)  \(selectedOption2) and a weight of \(weight) \(selectedOption) with a body structure of \(bodyStructure) wants to \(goal)working out at \(whereWork), in a Json file give me a list of excercises to train every muscule and divide them in \(numDays) days so each muscule can be trained in their own dedicated day and have in mind that the person wants to workout for \(numHours) hours. The format should be: day number it corresponds to, name of the excersise( in string) , repetitions(in string), number of series(an Int) and the approx calories burned (an Int). Ignore recomendations!"
            
      
        
        let chat = model.startChat(history: [
          ModelContent(role: "user", parts: "a male of 21 years with a height of 176 cm and a weight of 56 kg with a body structure of ectomorph wants to increase mass at gym, in a Json file give me the exact number(not in range) of protein, Calories, sugars, and Carbs, BurnCalories (that that person needs to burn daily), and water a day that person should consume to fulfill his goal. Do not include Important Considerations"),
          ModelContent(role: "model", parts: "```json\n{\n  \"protein\": 120, \n  \"calories\": 2800, \n  \"sugars\": 50, \n  \"carbs\": 300, \n  \"burnCalories\": 2000, \n  \"water\": 3.5 \n}\n```\n\n**Important Considerations:**\n\n* This is a **general guideline** and individual needs may vary.\n* It is **essential to consult with a qualified healthcare professional** before making significant changes to your diet or exercise routine.\n* **Individual factors** such as activity level, metabolism, and genetics will influence your specific needs.\n* **Consistency and gradual progression** are crucial for achieving sustainable results.\n* **Monitoring your progress and adjusting accordingly** is important to ensure optimal results. \n")
        ])

        let chatt = model.startChat(history: [
            ModelContent(role: "user", parts: "a male of 21 years with a height of 176 cm and a weight of 56 kg with a body structure of ectomorph wants to increase mass, in a Json file give me a list of excercises to train every muscule and divide them in 4 days so each muscule can be trained in their own dedicated day and have in mind that the person wants to workout for 1 - 2  hours. The format should be: day number it corresponds to, name of the excersise, repetitions, number of series and the approx calories burned. Ignore recomendations!"),
            ModelContent(role: "model", parts: "```json\n{\n  \"workout_plan\": [\n    {\n      \"day\": 1,\n      \"muscle_group\": \"Chest\",\n      \"exercises\": [\n        {\n          \"name\": \"Barbell Bench Press\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 200-300\n        },\n        {\n          \"name\": \"Incline Dumbbell Press\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 150-200\n        },\n        {\n          \"name\": \"Decline Dumbbell Press\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 150-200\n        },\n        {\n          \"name\": \"Cable Crossovers\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Push-ups\",\n          \"reps\": As many as possible (AMRAP),\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        }\n      ]\n    },\n    {\n      \"day\": 2,\n      \"muscle_group\": \"Back\",\n      \"exercises\": [\n        {\n          \"name\": \"Pull-ups\",\n          \"reps\": As many as possible (AMRAP),\n          \"sets\": 3,\n          \"calories_burned\": 150-200\n        },\n        {\n          \"name\": \"Barbell Rows\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 200-300\n        },\n        {\n          \"name\": \"T-Bar Row\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 150-200\n        },\n        {\n          \"name\": \"Lat Pulldowns\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Seated Cable Rows\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        }\n      ]\n    },\n    {\n      \"day\": 3,\n      \"muscle_group\": \"Legs\",\n      \"exercises\": [\n        {\n          \"name\": \"Squats\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 300-400\n        },\n        {\n          \"name\": \"Leg Press\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 200-300\n        },\n        {\n          \"name\": \"Leg Extensions\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Hamstring Curls\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Calf Raises\",\n          \"reps\": 15-20,\n          \"sets\": 3,\n          \"calories_burned\": 50-100\n        }\n      ]\n    },\n    {\n      \"day\": 4,\n      \"muscle_group\": \"Shoulders & Arms\",\n      \"exercises\": [\n        {\n          \"name\": \"Overhead Press\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 150-200\n        },\n        {\n          \"name\": \"Lateral Raises\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Front Raises\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Barbell Bicep Curls\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Hammer Curls\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Triceps Pushdowns\",\n          \"reps\": 12-15,\n          \"sets\": 3,\n          \"calories_burned\": 100-150\n        },\n        {\n          \"name\": \"Close-Grip Bench Press\",\n          \"reps\": 8-12,\n          \"sets\": 3,\n          \"calories_burned\": 150-200\n        }\n      ]\n    }\n  ]\n}\n```")
        ])
        
        Task {
            if height != 0{
                do {
                    let response1 = try await chat.sendMessage(message1)
                    let response2 = try await chatt.sendMessage(message2)
                    try await extractWorkoutPlan(from: response2.text ?? "")
                    try await extractNutrition(from: response1.text ?? "")
                } catch {
                    print("Error: \(error)")
                }
            }
            else{
            
                do {
                    let response1 = try await chat.sendMessage(message3)
                    let response2 = try await chatt.sendMessage(message4)
                    try await extractWorkoutPlan(from: response2.text ?? "")
                    try await extractNutrition(from: response1.text ?? "")
                } catch {
                    print("Error: \(error)")
                }
            }
            if age > 18  && ((height > 40 && weight > 40) || (heightFt > 3 && weight > 100)) {
                let urlString = Constants.baseURL + EndPoints.users
                
                guard let url = URL(string: urlString) else {
                    throw HttpEroor.badURL
                }
                
                
                let user = User(id: nil, firstName: self.firstName, lastName: self.lastName, age: self.age, gender: self.gender, weight: self.weight, goal: self.goal, bodyStructure: self.bodyStructure, height: self.height, DailyCalories: self.DailyCalories, DailyProtein: self.DailyProtein, email: self.email, password: self.password, heightFt: self.heightFt,heightInc: self.heightIn,numHours: self.numHours, numDays: self.numDays, sugars: self.sugars ?? 0, carbs: self.carbs ?? 1, burnCalories: self.DalyCaloriesBurn ?? 0, water: self.water ?? 0.0 )
//
//                let user = User(id: nil, firstName: self.firstName, lastName: self.lastName, age: self.age, gender: self.gender, weight: self.weight, goal: self.goal, bodyStructure: self.bodyStructure, height: self.height, DailyCalories: self.DailyCalories, DailyProtein: self.DailyProtein, email: self.email, password: self.password, numHours: self.numHours, numDays: self.numDays, excersises: excersise!)
                
                let fullTrainings = fullTraining(id: nil, email: self.email, userExcersises: excersise!)
                
                print(fullTrainings)
                
                try await HttpClient.shared.sendData(to: url, object: user, httpMethod: HttpMethods.POST.rawValue)
                
                
                guard let url = URL(string: "\(Constants.baseURL)\(EndPoints.training)?email=\(email)") else {
                    throw HttpEroor.badURL
                }
                
                print("URL: \(url)")
                print("Data being sent: \(fullTrainings)")

                do {
                    // Send the data
                    try await HttpClient.shared.sendData(to: url, object: fullTrainings, httpMethod: HttpMethods.POST.rawValue)
                    print("Data sent successfully.")
                } catch {
                    print("Failed to send data: \(error)")
                }
                
                
                
                submit = true
            }
        
            
            
        }
            
            }
        func extractNutrition(from response: String) async throws{
            // Remove the code block indicators from the JSON string
            var trimmedResponse = response.replacingOccurrences(of: "```json", with: "")
            trimmedResponse = trimmedResponse.replacingOccurrences(of: "```", with: "")
            trimmedResponse = trimmedResponse.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Convert the trimmed response to Data
            guard let jsonData = trimmedResponse.data(using: .utf8) else {
                print("Error converting JSON string to data")
                return
            }
            print(trimmedResponse)
            // Decode the JSON data
            let jsonDecoder = JSONDecoder()
            do {
                let nutritions = try jsonDecoder.decode(userNutrition.self, from: jsonData)
                self.DailyCalories = nutritions.calories
                self.DailyProtein = nutritions.protein
                self.carbs = nutritions.carbs
                self.sugars = nutritions.sugars
                self.water = nutritions.water
                self.DalyCaloriesBurn = nutritions.burnCalories
                print("Person -- \(nutritions.calories)")
                print("Saved calories = \(DailyCalories)")
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
            
            
            
        }
        
        
        func extractWorkoutPlan(from response: String) async throws{
            // Remove the code block indicators from the JSON string
            var trimmedResponse = response.trimmingCharacters(in: .whitespacesAndNewlines)
            // Remove the "```json" at the beginning
            if trimmedResponse.hasPrefix("```json") {
                trimmedResponse = String(trimmedResponse.dropFirst(7))
            }
            // Remove the "```" at the end
            if trimmedResponse.hasSuffix("```") {
                trimmedResponse = String(trimmedResponse.dropLast(3))
            }
            
            // Find the index of the last '}' to trim any text after that
            if let lastIndex = trimmedResponse.lastIndex(of: "}") {
                let substring = trimmedResponse[...lastIndex]
                trimmedResponse = String(substring)
            }
            
            // Convert the trimmed response to Data
            guard let jsonData = trimmedResponse.data(using: .utf8) else {
                print("Error converting JSON string to data")
                return
            }
            print(trimmedResponse)
            
            // Decode the JSON data
            let jsonDecoder = JSONDecoder()
            do {
                let workoutPlan = try jsonDecoder.decode(userExcersise.self, from: jsonData)
                excersise = workoutPlan
                print(workoutPlan)
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        
        
        
    
    
}

struct finalData_Previews: PreviewProvider {
    static var previews: some View {
        finalData(firstName: "da", lastName: "dad", gender: "dad", goal: "dasda", bodyStructure: "dasda", email: "adad", password: "dsada",numDays: 5, numHours: "2", whereWork: "Gym")
    }
}

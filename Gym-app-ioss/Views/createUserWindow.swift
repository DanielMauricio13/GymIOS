//
//  createUserWindow.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 8/15/23.
//

import SwiftUI

struct createUserWindow: View {
    @State var firstName: String = ""
    @State var lastName:String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State private var nextPart: Bool = false
  @State  var email: String = ""
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State var isDataSaved: Bool = false
    var body: some View {
        if isDataSaved{
            questionaire(firstName: firstName, lastName: lastName, email: email, password: password)
        }
        else {
            NavigationView{
                ZStack{
                    LinearGradient(colors: [Color.cyan.opacity(0.7),Color.black.opacity(0.7)],startPoint: .topLeading,endPoint: .bottomTrailing).ignoresSafeArea()
                    Circle().frame(width: 300).foregroundStyle(Color.blue.opacity(0.3)).blur(radius: 10).offset(x: -100, y: 150)
                    Circle().frame(width: 300).foregroundStyle(Color.purple.opacity(0.3)).blur(radius: 10).offset(x: 150, y: -250)
                    VStack{
                        Text("Create Account").foregroundColor(.white).padding(.top).font(.system(size: 35, weight: .bold, design: .rounded))
                        Form{
                            Section(header: Text("Name")) {
                                TextField("First Name", text: $firstName).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white).cornerRadius(10)
                                
                                TextField("Last Name", text: $lastName).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white)
                                
                            }
                            Section(header: Text("Email"), footer: Text("Email already registered").opacity(CGFloat(wrongEmail)).foregroundStyle(Color.red)){
                                TextField("Email", text: $email).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white).cornerRadius(10).listRowBackground(Rectangle().clipShape(.capsule).border(Color.red, width: CGFloat(wrongEmail)))
                            }
                            
                            Section(header: Text("Password"), footer: Text("Passwords do not match or is empty").opacity(CGFloat(wrongPassword)).foregroundStyle(Color.red)){
                                SecureField("Password", text: $password).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white)
                                SecureField("Confirm password", text: $confirmPassword).listRowBackground(Color.white.opacity(0.4)).foregroundColor(.white)
                            }
                            
                        }.scrollContentBackground(.hidden)
                        Button{
                            Task{
                                try await checkEmail(self.email)
                            }
                            
                        }label: {
                            Text("Next").foregroundColor(.white).background(Rectangle().clipShape(.capsule).frame(width: 70,height: 30))
                        }
                        
                    }
                }
            }
        }
    }
    
    func checkEmail(_ email: String) async throws -> Void {

        guard let url = URL(string: "\(Constants.baseURL)\(EndPoints.users)/checkEmail?email=\(email)") else {
             print("error")
            return
        }
        self.email = email.uppercased()
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    wrongEmail = 1
                    print("found")
                case 401:
                    wrongEmail = 0
                default:
                    wrongEmail = 0
                }

            }
            
            if password != confirmPassword || password == "" {
                wrongPassword = 1
            }else{
                wrongPassword = 0
            }
            
            if wrongEmail == 0 && wrongPassword == 0{
                nextView()
            }
        }
        
        task.resume()
        return
    }
    func nextView(){
        if firstName != "" && lastName != "" {
            isDataSaved = true
        }
    }
}

struct createUserWindow_Previews: PreviewProvider {
    static var previews: some View {
        createUserWindow()
    }
}

struct BasicInformationRecollection: View{
    var body: some View{
        Text("collect basic info")
    }
}

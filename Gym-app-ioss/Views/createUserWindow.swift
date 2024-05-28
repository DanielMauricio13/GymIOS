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
                    Color.black.ignoresSafeArea()
                    VStack{
                        Text("Create Account").font(.largeTitle).foregroundColor(.white).padding(.top)
                        Form{
                            Section(header: Text("Name")) {
                                TextField("First Name", text: $firstName).listRowBackground(Color.gray).foregroundColor(.white).cornerRadius(10)
                                
                                TextField("Last Name", text: $lastName).listRowBackground(Color.gray).foregroundColor(.white)
                                
                            }
                            Section(header: Text("Email"), footer: Text("Email already registered").opacity(CGFloat(wrongEmail)).foregroundStyle(Color.red)){
                                TextField("Email", text: $email).listRowBackground(Color.gray).foregroundColor(.white).cornerRadius(10).listRowBackground(Rectangle().clipShape(.capsule).border(Color.red, width: CGFloat(wrongEmail)))
                            }
                            
                            Section(header: Text("Password"), footer: Text("Passwords do not match").opacity(CGFloat(wrongPassword)).foregroundStyle(Color.red)){
                                SecureField("Password", text: $password).listRowBackground(Color.gray).foregroundColor(.white)
                                SecureField("Confirm password", text: $confirmPassword).listRowBackground(Color.gray).foregroundColor(.white)
                            }
                            
                        }.cornerRadius(10)
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
            
            if password != confirmPassword {
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
        if firstName != "" && lastName.count > 2 && password.count > 2 && email.count > 2 {
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

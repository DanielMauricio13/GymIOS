//
//  ContentView.swift
//  Gym-app-ioss
//
//  Created by Daniel Pinilla on 8/15/23.
//

import SwiftUI



struct LogInWindow: View {
    
   
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var userFound: Bool = false
    @State private var isAuthenticated = UserDefaults.standard.bool(forKey: "isAuthenticated")
    @State private var username = UserDefaults.standard.string(forKey: "username") ?? ""
   
    var body: some View {
        
            if userFound {
                
                    MainWindow(email: username)
                
            } else if isAuthenticated {
                MainWindow(email: username)
            } else {
                NavigationView {
                    ZStack {
                        Color.black.ignoresSafeArea()
                        Circle().scale(1.7).foregroundColor(.white.opacity(0.4))
                        Circle().scale(1.35).foregroundColor(.red)
                        Circle().scale(1).foregroundColor(.black)
                        Circle().scale(1).foregroundColor(.white.opacity(0.4))
                        Circle().scale(1).foregroundColor(.black.opacity(0.7))
                        VStack {
                            Text("Pow AI").font(.largeTitle).bold().padding(.bottom).foregroundColor(.white).padding(51)
                            TextField("Email", text: $username).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(wrongUsername)).foregroundColor(.white).font(.headline)
                            SecureField("Password", text: $password).foregroundStyle(Color.white).padding().frame(width: 300, height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red, width: CGFloat(wrongPassword)).accentColor(.white).foregroundColor(.white).font(.headline)
                            if wrongUsername == 1 {
                                NavigationLink(destination: createUserWindow()) {
                                    Text("Wrongh email or password. Recover?").underline().foregroundColor(.red)
                                }.padding(.top)
                            }
                            Button {
                                self.username = username.uppercased()
                                authenticateUser(username, password)
                            } label: {
                                Text("LogIn").padding().foregroundColor(.white).frame(width: 300, height: 50).background(Color.blue).cornerRadius(10)
                            }

                            NavigationLink(destination: createUserWindow()) {
                                Text("New? Create User").foregroundColor(.white)
                            }.padding(.top)
                        }
                    }.navigationBarBackButtonHidden()
                }.navigationBarBackButtonHidden()
                
            }
    }
    
    func authenticateUser(_ user: String, _ password: String)  {
        
        guard let url = URL(string: "\(Constants.baseURL)\(EndPoints.users)/checkCredentials?email=\(user)&password=\(password)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    userFound = true
                    isAuthenticated = true
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    UserDefaults.standard.set(username, forKey: "username")
                    UserDefaults.standard.set(true, forKey: "isAuthenticated")
                    break;
                case 401:
                    print("Credentials do not match")
                    wrongPassword = 1
                    wrongUsername = 1
                case 404:
                    print("Credentials do not match")
                    wrongPassword = 1
                    wrongUsername = 1
                default:
                    print("Unknown response status: \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
}

struct LogInWindow_Previews: PreviewProvider {
    static var previews: some View {
        LogInWindow()
    }
}

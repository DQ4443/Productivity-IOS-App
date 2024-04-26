//
//  LoginView.swift
//  Pomo.do
//
//  Created by David Qu on 4/22/24.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    @State private var isLoggedIn = false
    @State private var showInvalidCredentialsText = false
    
    // [Beta] TODO: add sign in with Google
    // [Beta] TODO: add remember me functionality
    // [Beta] TODO: add forgot password functionality with password reset
//    @AppStorage("rememberMe") private var rememberMeEnabled = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 0.95)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // Title text
                    HStack {
                        Text("Log in")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, 50)
                            .padding(.leading, 50)
                        
                        Spacer()
                        
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up >")
                                .font(.subheadline)
                                .padding(.top, 50)
                                .padding(.trailing, 70)
                                .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                .bold()
                        }
                    }
                    .padding(.top, 50)
                    
                    // invalid credentials text
                    if showInvalidCredentialsText {
                        HStack {
                            Text("Invalid Login Credentials")
                                .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                                .padding(.top, 2)
                                .padding(.bottom, -40)
                                .font(.caption)
                                .padding(.horizontal, 40)
                            Spacer()
                        }
                        
                    }
                    
                    // VStack for email and password
                    VStack {
                        // Email Box
                        VStack {
                            HStack {
                                Text("Email")
                                    .font(.subheadline)
                                    .padding(.top, 20)
                                    .padding(.bottom, -20)
                                // for alignment
                                Spacer()
                            }
                            
                            TextField("Email", text: $email)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                                .cornerRadius(5.0)
                                .padding(.top, 20)
                        }
                        
                        // Password Box
                        VStack {
                            HStack {
                                Text("Password")
                                    .font(.subheadline)
                                    .padding(.top, 20)
                                    .padding(.bottom, -20)
                                // for alignment
                                Spacer()
                            }
                            
                            SecureField("Password", text: $password)
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                                .cornerRadius(5.0)
                                .padding(.top, 20)

                        }
                    }
                    .padding(.horizontal, 40)
                    
                    // Remember me and Forgot Password
                    HStack {
                        Button(action: {
                            rememberMe.toggle()
                        }) {
                            Image(systemName: rememberMe ? "checkmark.square.fill" : "square")
                                .resizable()
                                .frame(width: 20, height: 20)
                            
                                .foregroundColor(Color.black)
                            
                        }
                        
                        
                        Text("Remember me")
                        
                        Spacer()
                        
                        Text("Forgot Password?")
                            .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            .font(.subheadline)
                            .bold()
                    }
                    .padding(.top, 30)
                    .padding(.horizontal, 40)
                    
                    // Log in button
                    VStack {
                        Button(action: {
                            login()
                        }) {
                            Text("Log in")
                                .bold()
                                .padding()
                                .frame(width: 350, height: 50)
                                .background(Color(red: 0.8, green: 0, blue: 0))
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .padding(.top, 30)
                        }
                        .navigationDestination(isPresented: $isLoggedIn) {
                            MainView()
                        }

                    }
                    
                    // Login with Google
                    VStack {
                        Text("Or log in with:")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.top, 60)
                            .padding(.bottom, 10)
                        
                        
                        NavigationLink(destination: MainView()) {
                            Image("GoogleG")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.blue)
                                .padding()
                                .background(
                                    Rectangle()
                                        .fill(.white)
                                        .frame(width: 350, height: 50)
                                        
                                )
                        }
                    }
                  
                    Spacer()
                    
                }
            }
        }
        // [Beta] TODO: add remember me functionality
//        .onAppear {
//            if rememberMeEnabled {
//                isLoggedIn = true
//            }
//        }
        .navigationBarBackButtonHidden(true)
        
        
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print(error.localizedDescription)
                showInvalidCredentialsText = true
            } else {
                print("Login successful")
                isLoggedIn = true
                showInvalidCredentialsText = false
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(DataManager())
}

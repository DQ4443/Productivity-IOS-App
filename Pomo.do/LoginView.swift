//
//  LoginView.swift
//  Pomo.do
//
//  Created by David Qu on 4/22/24.
//

import SwiftUI


struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var rememberMe = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color(red: 0.95, green: 0.95, blue: 0.95)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // Login and Sign up
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
                        NavigationLink(destination: MainView()) {
                            Text("Log in")
                                .bold()
                                .padding()
                                .frame(width: 350, height: 50)
                                .background(Color(red: 0.8, green: 0, blue: 0))
                                .foregroundColor(Color.white)
                                .cornerRadius(10)
                                .padding(.top, 30)
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
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    LoginView()
}

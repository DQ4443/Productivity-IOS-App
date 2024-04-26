//
//  SignUpView.swift
//  Pomo.do
//
//  Created by David Qu on 4/22/24.
//

import SwiftUI
import Firebase

struct SignUpView: View {
    @EnvironmentObject var dataManager: DataManager
    
    // [Beta] TODO: add sign up with Google
    
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var signUpSuccessful = false
    @State private var showMissingNameError = false
    @State private var showPassowrdMismatchError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea(.all)
            
            VStack {
                // Sign Up and Log In
                HStack {
                    Text("Sign Up")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 50)
                        .padding(.leading, 50)
                    
                    Spacer()
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Log In >")
                            .font(.subheadline)
                            .padding(.top, 50)
                            .padding(.trailing, 70)
                            .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            .bold()
                    }
                }
                .padding(.top, 50)
                
                // invalid credentials text
                HStack {
                    if showPassowrdMismatchError {
                        Text("The passwords don't match.")
                            .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            .padding(.top, -5)
                            .padding(.bottom, -40)
                            .font(.caption)
                            .padding(.horizontal, 40)
                    } else if showMissingNameError {
                        Text("Name cannot be blank.")
                            .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            .padding(.top, -5)
                            .padding(.bottom, -40)
                            .font(.caption)
                            .padding(.horizontal, 40)
                    } else if errorMessage != "" {
                        Text(errorMessage)
                            .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            .padding(.top, -5)
                            .padding(.bottom, -40)
                            .font(.caption)
                            .padding(.horizontal, 40)
                    } else if signUpSuccessful {
                        Text("Sign Up Successful. Going Back to Login Page.")
                            .foregroundColor(Color(red: 0, green: 0.7, blue: 0))
                            .padding(.top, -5)
                            .padding(.bottom, -40)
                            .font(.caption)
                            .padding(.horizontal, 40)
                    } else {
                        Text("")
                            .foregroundColor(Color(red: 0.8, green: 0, blue: 0))
                            .padding(.top, -5)
                            .padding(.bottom, -40)
                            .font(.caption)
                            .padding(.horizontal, 40)
                    }
                
                    
                    Spacer()
                }
                    
                
                
                // Form
                VStack {
                    // Name Box
                    VStack {
                        HStack {
                            Text("Name")
                                .font(.subheadline)
                                .padding(.top, 10)
                                .padding(.bottom, -20)
                            Spacer()
                        }
                        
                        TextField("Name", text: $name)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(5.0)
                            .padding(.top, 20)
                    }
                    
                    // Email Box
                    VStack {
                        HStack {
                            Text("Email")
                                .font(.subheadline)
                                .padding(.top, 10)
                                .padding(.bottom, -20)
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
                                .padding(.top, 10)
                                .padding(.bottom, -20)
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
                    
                    // Password Confirmation Box
                    VStack {
                        HStack {
                            Text("Password Confirmation")
                                .font(.subheadline)
                                .padding(.top, 10)
                                .padding(.bottom, -20)
                            Spacer()
                        }
                        
                        SecureField("Password Confirmation", text: $confirmPassword)
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
                
                // Sign Up Button
                VStack {
                    Button(action: {
                        registerUser()
                        print(signUpSuccessful)
                    }) {
                        Text("Sign Up")
                            .bold()
                            .padding()
                            .frame(width: 350, height: 50)
                            .background(Color(red: 0.8, green: 0, blue: 0))
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .padding(.top, 30)
                    }
                    .navigationDestination(isPresented: $signUpSuccessful) {
                        LoginView()
                    }
                }
                
                // Sign Up with Google
                VStack {
                    Text("Or sign up with (Beta):")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.top, 30)
                        .padding(.bottom, 10)
                    
                    NavigationLink(destination: LoginView()) {
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
        .navigationBarBackButtonHidden(true)
        
    }
    
    // function for registering users
    func registerUser() {
        if password != confirmPassword {
            showPassowrdMismatchError = true
            print("Passwords don't match.")
            print(showPassowrdMismatchError)
            return
        } else if name.isEmpty {
            showMissingNameError = true
            print("Name cannot be blank.")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if (error != nil) {
                print(error!.localizedDescription)
                errorMessage = error!.localizedDescription
            } else {
                print("User created successfully.")
                signUpSuccessful = true
                showMissingNameError = false
                showPassowrdMismatchError = false
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(DataManager())
    }
}

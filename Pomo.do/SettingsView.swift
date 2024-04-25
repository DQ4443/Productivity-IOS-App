//
//  SettingsView.swift
//  Pomo.do
//
//  Created by David Qu on 4/23/24.
//

import SwiftUI

struct SettingsView: View {
    @Binding var name: String
    @Binding var email: String
    @Binding var pomoLengthMinutes: Int
    @Binding var breakLengthMinutes: Int
    @Binding var swipeControlOn: Bool
    @Binding var syncDataBetweenDevices: Bool
    
    @State private var nameTemp = ""
    @State private var emailTemp = ""
    @State private var pomoLengthMinutesTemp = 25
    @State private var breakLengthMinutesTemp = 5
    @State private var swipeControlOnTemp = true
    @State private var syncDataBetweenDevicesTemp = false
    
    public init(name: Binding<String>, email: Binding<String>, pomoLengthMinutes: Binding<Int>, breakLengthMinutes: Binding<Int>, swipeControlOn: Binding<Bool>, syncDataBetweenDevices: Binding<Bool>) {
        self._name = name
        self._email = email
        self._pomoLengthMinutes = pomoLengthMinutes
        self._breakLengthMinutes = breakLengthMinutes
        self._swipeControlOn = swipeControlOn
        self._syncDataBetweenDevices = syncDataBetweenDevices
        
        self._nameTemp = State(initialValue: name.wrappedValue)
        self._emailTemp = State(initialValue: email.wrappedValue)
        self._pomoLengthMinutesTemp = State(initialValue: pomoLengthMinutes.wrappedValue)
        self._breakLengthMinutesTemp = State(initialValue: breakLengthMinutes.wrappedValue)
        self._swipeControlOnTemp = State(initialValue: swipeControlOn.wrappedValue)
        self._syncDataBetweenDevicesTemp = State(initialValue: syncDataBetweenDevices.wrappedValue)
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea(.all)
            
            
            VStack {
                // Title
                HStack {
                    Text("Settings")
                        .font(.largeTitle)
                        .bold()
                    
//                    Spacer()
                }
                .padding(.bottom, 20)

                // Form Section
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
                        
                        TextField("Name", text: $nameTemp)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(5.0)
                            .padding(.top, 20)
                            .autocorrectionDisabled()
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
                        
                        TextField("Email", text: $emailTemp)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 2)
                            )
                            .cornerRadius(5.0)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                            .autocorrectionDisabled()
                    }
                    
                }
                
                Divider()
                
                // Section Heading
                HStack {
                    Text("Pomodoro Timer Settings")
                        .font(.title3)
                        .bold()
                        .padding(.top, 15)
                        .padding(.bottom, 10)
                        
                    Spacer()
                }
                
                // Timer Block Length Setting Section
                VStack {
                    // Pomo Duration
                    HStack {
                        Text("Pomo Duration:")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        // space and arrows
                        HStack(spacing: 0) {
                            TextField("", value: $pomoLengthMinutesTemp, formatter: NumberFormatter())
                                .font(.headline)
                                .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                .frame(width: 100)
                                .keyboardType(.numberPad)
                                .padding(.trailing, 5)
                                .multilineTextAlignment(.center)
                            
                            VStack(spacing: 0) {
                                Button(action: {
                                    if pomoLengthMinutesTemp < 60 {
                                        pomoLengthMinutesTemp += 1
                                    }
                                }) {
                                    Image(systemName: "chevron.up")
                                        .font(.system(size: 10))
                                        .padding(2)
                                        .foregroundColor(.white)
                                        .background(Color(red: 0.8, green: 0, blue: 0))
                                        .cornerRadius(4)
                                        .padding(.vertical, 1)
                                }
                                
                                Button(action: {
                                    if pomoLengthMinutesTemp > 1 {
                                        pomoLengthMinutesTemp -= 1
                                    }
                                }) {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 10))
                                        .padding(2)
                                        .foregroundColor(.white)
                                        .background(Color(red: 0.8, green: 0, blue: 0))
                                        .cornerRadius(4)
                                        .padding(.vertical, 1)
                                }
                            }
                            
                            
                            Spacer()
                            
                        }
                        
                    }
                    .padding(.bottom, 10)
                    
                    // Break Duration
                    HStack {
                        Text("Break Duration:")
                            .font(.subheadline)
                        
                        Spacer()
                        
                        // Space and arrows
                        HStack(spacing: 0) {
                            TextField("", value: $breakLengthMinutesTemp, formatter: NumberFormatter())
                                .font(.headline)
                                .background(Color(red: 0.8, green: 0.8, blue: 0.8))
                                .frame(width: 100)
                                .keyboardType(.numberPad)
                                .padding(.trailing, 5)
                                .multilineTextAlignment(.center)
                            
                            VStack(spacing: 0) {
                                Button(action: {
                                    if breakLengthMinutesTemp < 60 {
                                        breakLengthMinutesTemp += 1
                                    }
                                }) {
                                    Image(systemName: "chevron.up")
                                        .font(.system(size: 10))
                                        .padding(2)
                                        .foregroundColor(.white)
                                        .background(Color(red: 0.8, green: 0, blue: 0))
                                        .cornerRadius(4)
                                        .padding(.vertical, 1)
                                }
                                
                                Button(action: {
                                    if breakLengthMinutesTemp > 1 {
                                        breakLengthMinutesTemp -= 1
                                    }
                                }) {
                                    Image(systemName: "chevron.down")
                                        .font(.system(size: 10))
                                        .padding(2)
                                        .foregroundColor(.white)
                                        .background(Color(red: 0.8, green: 0, blue: 0))
                                        .cornerRadius(4)
                                        .padding(.vertical, 1)
                                }
                            }
                            
                            
                            Spacer()
                        
                        }
                        
                        
                    }
                }
                .padding(.bottom, 20)
                
                Divider()
                    .padding(.bottom, 20)
                
                // Swipe Controls Section
                VStack {
                    HStack {
                        Text("Swipe Controls")
                            .font(.subheadline)
                            .bold()
                        
                        Toggle("", isOn: $swipeControlOnTemp)
                            .tint(Color(red: 0.8, green: 0, blue: 0))
                            .padding(.trailing, 10)
                        
                        Spacer()
                    }
                    .padding(.bottom, 20)
                }
                
                // [Beta] Sync Data Section
                VStack {
                    HStack {
                        Text("Sync Data Between Devices")
                            .font(.subheadline)
                            .bold()
                        
                        Toggle("", isOn: $syncDataBetweenDevicesTemp)
                            .tint(Color(red: 0.8, green: 0, blue: 0))
                            .padding(.trailing, 10)
                        
                        Spacer()
                    }
                }
                
                Spacer()
                
                // Save Button TODO: handle save settings
                VStack {
                    Button(action: {
                        // TODO: handle save settings
                        name = nameTemp
                        email = emailTemp
                        pomoLengthMinutes = pomoLengthMinutesTemp
                        breakLengthMinutes = breakLengthMinutesTemp
                        swipeControlOn = swipeControlOnTemp
                        syncDataBetweenDevices = syncDataBetweenDevicesTemp
                    }) {
                        Text("Save")
                            .font(.title3)
                            .bold()
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color(red: 0.8, green: 0, blue: 0))
                            .cornerRadius(10)
                    }
                    .padding(.top, -50)
                }
                
                Text("*Make sure to save any changes made")
                    .padding()
                    .font(.caption)
                
                Spacer()
                
                // Test Save Button
//                VStack {
//                    Button(action: {
//                        // TODO: handle save settings
//                        print(name, swipeControlOn, swipeControlOnTemp, syncDataBetweenDevices)
//                    }) {
//                        Text("Save Test")
//                            .font(.title3)
//                            .bold()
//                            .frame(width: 300, height: 50)
//                            .foregroundColor(.white)
//                            .background(Color(red: 0.8, green: 0, blue: 0))
//                            .cornerRadius(10)
//                    }
//                    .padding(.top, -80)
//                    Spacer()
//                }
                
                    
            }
            .padding(.horizontal, 60)
            .padding(.top, 30)
            
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SettingsView(name: .constant("Jimmi"), email: .constant("Jimmi@gmail.com"), pomoLengthMinutes: .constant(25), breakLengthMinutes: .constant(5), swipeControlOn: .constant(true), syncDataBetweenDevices: .constant(true))
}

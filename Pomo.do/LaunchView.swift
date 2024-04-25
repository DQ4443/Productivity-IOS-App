//
//  ContentView.swift
//  Pomo.do
//
//  Created by David Qu on 4/19/24.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 1, green: 0, blue: 0),
                        Color(red: 0.6, green: 0, blue: 0)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    // Logo
                    VStack {
                        Image("pomologo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                        Text("Pomo.do")
                            .font(.title)
                            .bold()
                    }
                    
                    Spacer()
                    
                    // Begin Button
                    VStack {
                        NavigationLink(destination: LoginView()) {
                            Text("Begin >")
                                .foregroundColor(.black)
                                .font(.system(size: 20, weight: .bold))
                                .background(Color.clear)
                                .cornerRadius(10)
                                .padding(.vertical, 40)
                                .padding(.horizontal, 40)
                            
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    LaunchView()
}

//
//  Pomo_doApp.swift
//  Pomo.do
//
//  Created by David Qu on 4/19/24.
//

import SwiftUI
import Firebase

@main
struct Pomo_doApp: App {
    @StateObject var dataManager = DataManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(dataManager)
        }
    }
}

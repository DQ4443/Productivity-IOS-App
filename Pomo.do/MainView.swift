//
//  MainView.swift
//  Pomo.do
//
//  Created by David Qu on 4/23/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition { transform(self) }
        else { self }
    }
}

struct MainView: View {
    @EnvironmentObject var dataManager: DataManager
    
    @State private var name = ""
    @State private var email = ""
    @State private var pomoLengthMinutes = 25
    @State private var breakLengthMinutes = 5
    @State private var swipeControlOn = true
    @State private var syncDataBetweenDevices = false
    
    // swipe and show bar functionality (laggy)
//    @State private var selectedTab: Int = 1
//    let minDragTranslationForSwipe: CGFloat = 0
//    let numTabs = 3
    
    init() {
        // customize navigation bar
        UITabBar.appearance().backgroundColor = .white // Set the background color
        UITabBar.appearance().unselectedItemTintColor = .gray // Set the unselected item color
        UITabBar.appearance().tintColor = .red
    }
    
    var body: some View {
        ZStack {
            Color(red: 0.95, green: 0.95, blue: 0.95)
                .ignoresSafeArea()
            // swipe and show bar functionality (laggy)
    //        TabView(selection: $selectedTab) {
            TabView {
                HomeView(name: $name)
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .if(!swipeControlOn) { view in
                        view.padding(.bottom, 20)
                    }
                
                // swipe and show bar functionality (laggy)
    //                .tag(0)
    //                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
                    
                    
                TimerView(pomoLengthMinutes: $pomoLengthMinutes, breakLengthMinutes: $breakLengthMinutes)
                    .tabItem {
                        Image(systemName: "clock")
                        Text("Timer")
                    }
                // swipe and show bar functionality (laggy)
    //                .tag(1)
    //                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
                SettingsView(name: $name,
                             email: $email,
                             pomoLengthMinutes: $pomoLengthMinutes,
                             breakLengthMinutes: $breakLengthMinutes,
                             swipeControlOn: $swipeControlOn,
                             syncDataBetweenDevices: $syncDataBetweenDevices
                )
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }
                    .if(!swipeControlOn) { view in
                        view.padding(.bottom, 20)
                    }
                // swipe and show bar functionality (laggy)
    //                .tag(2)
    //                .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
            }
            .if(swipeControlOn) { view in
                view.tabViewStyle(.page)
            }
            .accentColor(Color(red:0.8, green:0, blue:0))
            .navigationBarBackButtonHidden(true)
        }
    }
    
    // swipe and show bar functionality (laggy)
//    private func handleSwipe(translation: CGFloat) {
//        if translation > minDragTranslationForSwipe && selectedTab > 0 {
//            selectedTab -= 1
//        } else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
//            selectedTab += 1
//        }
//        print(selectedTab)
//    }

}

#Preview {
    MainView()
        .environmentObject(DataManager())
}

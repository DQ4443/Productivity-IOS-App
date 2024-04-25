////
////  NavigationBarView.swift
////  Pomo.do
////
////  Created by David Qu on 4/23/24.
////
//
//import SwiftUI
//
//enum Tab: String, CaseIterable {
//    case house
//    case clock
//    case gearshape
//}
//
//struct NavigationBarView: View {
//    @Binding var selectedTab: Tab
//    private var fillImage: String {
//        selectedTab.rawValue + ".fill"
//    }
//    
//    
//    
//    var body: some View {
//        NavigationStack {
//            VStack {
//                HStack {
//                    ForEach(Tab.allCases, id: \.rawValue) { tab in
//                        Spacer()
//                        Image(systemName: selectedTab == tab ? fillImage : tab.rawValue)
//                            .scaleEffect(selectedTab == tab ? 1.25 : 1.0)
//                            .foregroundColor(selectedTab == tab ? Color(red:0.8, green:0, blue:0) : .gray)
//                            .font(.system(size: 22))
//                            .onTapGesture {
//                                withAnimation(.easeInOut(duration: 0.1)) {
//                                    selectedTab = tab
//                                }
//                            }
//                        Spacer()
//                    }
//                }
//                .frame(width: nil, height: 60)
//                .background(.thinMaterial)
//                .cornerRadius(10)
//                .padding()
//                
//            }
//        }
//        
//    }
//        
//        
//        
////        NavigationStack {
////            HStack {
////                Spacer()
////                
////                
////                NavigationLink(destination: HomeView()) {
////                    Image(systemName: "house")
////                        .resizable()
////                        .frame(width: 28, height: 25)
////                        .foregroundColor(selectedTab == 0 ? Color(red: 0.8, green: 0, blue: 0) : .gray)
////                }
////                .simultaneousGesture(TapGesture().onEnded {
////                    selectedTab = 0
////                    print(selectedTab)
////                })
////                
////                Spacer()
////                
////                NavigationLink(destination: TimerView()) {
////                    Image(systemName: "clock")
////                        .resizable()
////                        .frame(width: 25, height: 25)
////                        .foregroundColor(selectedTab == 1 ? Color(red: 0.8, green: 0, blue: 0) : .gray)
////                }
////                .simultaneousGesture(TapGesture().onEnded {
////                    selectedTab = 1
////                    print(selectedTab)
////                })
////                
////                Spacer()
////                
////                NavigationLink(destination: SettingsView()) {
////                    Image(systemName: "gearshape")
////                        .resizable()
////                        .frame(width: 25, height: 25)
////                        .foregroundColor(selectedTab == 2 ? Color(red: 0.8, green: 0, blue: 0) : .gray)
////                }
////                .simultaneousGesture(TapGesture().onEnded {
////                    selectedTab = 2
////                    print(selectedTab)
////                })
////                
////                Spacer()
////            }
////            .padding(.top, 30)
////            .background(.white)
////        }
////    }
//}
//
//#Preview {
//    NavigationBarView(selectedTab: .constant(.house))
//}

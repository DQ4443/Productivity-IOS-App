//
//  TimerView.swift
//  Pomo.do
//
//  Created by David Qu on 4/23/24.
//

import SwiftUI

enum TimerState {
    case running
    case paused
    case stopped
    case onBreak
}

struct TimerView: View {
    @Binding var pomoLengthMinutes: Int
    @Binding var breakLengthMinutes: Int
    
    @State var timeRemaining = 3 // 25 min by default
    @State var timerState: TimerState = .stopped
    
    init(pomoLengthMinutes: Binding<Int>, breakLengthMinutes: Binding<Int>) {
        self._pomoLengthMinutes = pomoLengthMinutes
        self._breakLengthMinutes = breakLengthMinutes
        self._timeRemaining = State(initialValue: pomoLengthMinutes.wrappedValue * 60)
    }
    
    var timerProgress: Double {
        if (timerState == .onBreak) {
            return 1 - Double(timeRemaining) / Double(breakLengthMinutes * 60)
        } else {
            return 1 - Double(timeRemaining) / Double(pomoLengthMinutes * 60)
        }
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(getTitleText())
                .font(.title)
                .padding()
            
            Spacer()
            
            // TODO: change highlight color to green for all elements while on break
            // TODO: customizable in settings
            
            // Timer Component
            ZStack {
                Circle()
                    .stroke(
                        Color(red:0.8, green:0.8, blue:0.8).opacity(0.5),
                        lineWidth: 15
                    )
                Circle()
                    .trim(from: 0, to: timerProgress)
                    .stroke(
                        Color(red:0.8, green:0, blue:0),
                        style: StrokeStyle(
                            lineWidth: 15,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.easeOut, value: timerProgress)
                Text(formatTime(timeRemaining))
                    .font(.system(size: 50, weight: .bold))
                    .padding(.horizontal)
                if (timerState == .paused) {
                    Text("paused")
                        .padding(.top, 75)
                }
            }
            .frame(width: 2500, height: 250)
            
            Spacer()
            
            // Timer Button Top
            Button(action: {
                toggleTimerState()
            }) {
                if (timerState == .running) {
                    Text("Pause")
                        .font(.headline)
                        .foregroundColor(Color(red:0.8, green:0, blue:0))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.95, green:0.95, blue: 0.95))
                        )
                        .overlay (
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red:0.8, green:0, blue:0), lineWidth: 2)
                        )
                } else if (timerState == .paused) {
                    Text("Continue")
                        .font(.headline)
                        .foregroundColor(Color(red:0.95, green:0.95, blue: 0.95))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.8, green:0, blue:0))
                        )
                } else if (timerState == .stopped) {
                    Text("Start")
                        .font(.headline)
                        .foregroundColor(Color(red:0.95, green:0.95, blue: 0.95))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.8, green:0, blue:0))
                        )
                } else { // on break
                    Text("Skip")
                        .font(.headline)
                        .foregroundColor(Color(red:0.95, green:0.95, blue: 0.95))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.8, green:0, blue:0))
                        )
                    
                }
            }
            .padding()
            
            // Timer Button Bottom
            Button(action: {
                if (timerState == .paused) {
                    resetTimer()
                } else if (timerState == .running) {
                    timerState = .onBreak
                    timeRemaining = breakLengthMinutes * 60
                }
            }) {
                if (timerState == .paused) {
                    Text("End")
                        .font(.headline)
                        .foregroundColor(Color(red:0.8, green:0, blue:0))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.95, green:0.95, blue: 0.95))
                        )
                        .overlay (
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red:0.8, green:0, blue:0), lineWidth: 2)
                        )
                } else if (timerState == .running) {
                    Text("Skip")
                        .font(.headline)
                        .foregroundColor(Color(red:0.95, green:0.95, blue: 0.95))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.8, green:0, blue:0))
                        )
                } else {
                    Text("")
                        .font(.headline)
                        .foregroundColor(Color(red:0.8, green:0, blue:0))
                        .frame(width: 200, height: 50)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color(red:0.95, green:0.95, blue: 0.95))
                        )
                        .overlay (
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color(red:0.8, green:0, blue:0), lineWidth: 0)
                        )
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .onChange(of: pomoLengthMinutes) {
            timeRemaining = pomoLengthMinutes * 60
        }
        // Timer Logic
        .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
            if (timerState == .running || timerState == .onBreak) && (timeRemaining > 0) {
                timeRemaining -= 1
            } else if timerState == .running && timeRemaining == 0 {
                timerState = .onBreak
                timeRemaining = breakLengthMinutes * 60 // break time
            } else if timerState == .onBreak && timeRemaining == 0 {
                resetTimer()
            }
        }
    }
    
    // function to format time display text
    func formatTime(_ time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // function to toggle timer state
    func toggleTimerState() {
        switch timerState {
        case .running:
            timerState = .paused
        case .paused:
            timerState = .running
        case .stopped:
            timerState = .running
        case .onBreak:
            resetTimer()
        }
    }
    
    // function to reset timer
    func resetTimer() {
        timeRemaining = pomoLengthMinutes * 60
        timerState = .stopped
    }
    
    // function to get title displayed
    func getTitleText() -> String {
        switch timerState {
        case .running:
            return "Focus"
        case .paused:
            return "Paused"
        case .stopped:
            return "Pomodoro Timer"
        case .onBreak:
            return "Take a Break"
        }
    }
    
}

#Preview {
    TimerView(pomoLengthMinutes: .constant(1), breakLengthMinutes: .constant(1))
}

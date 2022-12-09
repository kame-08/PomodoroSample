//
//  ContentView.swift
//  PomodoroSample
//
//  Created by Ryo on 2022/12/09.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var timerManager = TimerManager()
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack{
                    Image(systemName: "sun.max.fill")
                    Picker("", selection: $timerManager.gannbariTime) {
                        Text("5分")
                            .tag(300.0)
                        Text("10分")
                            .tag(600.0)
                        Text("15分")
                            .tag(900.0)
                    }
                }
                Spacer()
                Image(systemName: "repeat")
                Spacer()
                VStack{
                    Image(systemName: "moon.fill")
                    Picker("", selection: $timerManager.oyasumiTime) {
                        Text("5分")
                            .tag(300.0)
                        Text("10分")
                            .tag(600.0)
                        Text("15分")
                            .tag(900.0)
                    }
                }
                Spacer()
            }
            Spacer()
            ZStack {
                Circle()
                    .stroke(lineWidth: 30.0)
                    .opacity(0.2)
                    .foregroundColor(Color.accentColor)

                Circle()
                    .trim(from: 0.0, to: (timerManager.nowTime/timerManager.gannbariTime))
                    .stroke(style: StrokeStyle(lineWidth: 30.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.accentColor)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.default , value: timerManager.nowTime)
                Text(timerManager.format(time: timerManager.gannbariTime - timerManager.nowTime))
                    .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .medium)))
            }
            
            .padding(.horizontal, 40.0)
            Spacer()
            
           
            Button(action: {
                if timerManager.isTimerRunning {
                    timerManager.stopCounting()
                } else {
                    timerManager.startCounting()
                }
            }, label: {
                if timerManager.isTimerRunning {
                    Label("終了", systemImage: "stop.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                } else {
                    Label("開始", systemImage: "play.fill")
                        .padding()
                        .frame(maxWidth: .infinity)
                }
                    
            })
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .buttonStyle(.borderedProminent)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

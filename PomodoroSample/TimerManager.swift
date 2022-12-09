//
//  TimerManager.swift
//  PomodoroSample
//
//  Created by Ryo on 2022/12/09.
//

import Foundation
import Combine

class TimerManager: ObservableObject {
    
    //    @Published var endTime: TimeInterval = 900
    //経過時間
    @Published var nowTime: TimeInterval = 0.0
    
    //分
    @Published var gannbariTime = 900.0
    //分
    @Published var oyasumiTime = 5
    
    
    //    @Published var count = 0.01
    @Published var countFormat = "00:00.00"
    @Published var isTimerRunning = false
    
    //Startしているかどうか
    @Published var isStart = false
    
    private var cancellable: AnyCancellable?
    
    func startCounting() {
        isTimerRunning = true
        cancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                if self.nowTime < self.gannbariTime{
                    self.nowTime += 1
                } else {
                    self.nowTime = 0
                }

            }
    }
    
    func stopCounting() {
        isTimerRunning = false
        cancellable?.cancel()
    }
    
    func resetCount() {
        nowTime = TimeInterval(gannbariTime)
    }

    
    func format(time: TimeInterval) -> String{
        let dateFormatter = DateComponentsFormatter()
        dateFormatter.unitsStyle = .positional
        dateFormatter.allowedUnits = [.hour, .minute, .second]
        return dateFormatter.string(from: time)!
    }
}

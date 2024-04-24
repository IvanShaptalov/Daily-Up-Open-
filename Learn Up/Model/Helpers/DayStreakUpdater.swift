//
//  DayStreakUpdater.swift
//  Learn Up
//
//  Created by PowerMac on 08.02.2024.
//

import Foundation



class DayStreakUpdateProvider {
    static var resultIn = Calendar.Component.day
    
    static var dayStreak = getDayStreak()
    
    static func getStartOfValue(date: Date, component: Calendar.Component) -> Date{
        if component != Calendar.Component.day {
            return date
        }
        return Calendar.current.startOfDay(for: date)
    }
    
    static func getDayStreak() -> DayStreak {
        let timeNow = getStartOfValue(date: .now, component: resultIn)
        NSLog("day streak updated ⏰")
        var apd = DayStreakStorage.load()
        
        let isSameDay = apd.created.fullDistance(from: timeNow, resultIn: resultIn)
        if isSameDay == 0 {
            NSLog("same day ☀️")

            apd.created = getStartOfValue(date: apd.created, component: resultIn)
            DayStreakStorage.save(apd: apd)
            return apd
        }
        
        // if 1 day passed
        if isSameDay == 1 {
            NSLog("next day 🌞")

            apd.count += 1
            apd.created = timeNow
            DayStreakStorage.save(apd: apd)
            return apd
        }
        // if more than 1 day passed
        else {
            NSLog("too late 🚂")

            apd = .init(count: 1, created: timeNow)
            DayStreakStorage.save(apd: apd)
            return apd
        }
    }
    
    static func reset() {
        DayStreakStorage.remove()
    }
}

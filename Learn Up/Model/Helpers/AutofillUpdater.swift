//
//  AutofillUpdater.swift
//  Learn Up
//
//  Created by PowerMac on 30.01.2024.
//

import Foundation


class AutofillUpdateProvider {
    static let resultIn = Calendar.Component.day
    
    static func saveAutofill() -> AutofillPerDay {
        let apd = getUpdatedAutofill(incrementDay: true)
        return apd
    }
    
    static func getUpdatedAutofill(incrementDay: Bool) -> AutofillPerDay {
        var apd = AutoFillPerDayStorage.load()
        
        let isSameDay = apd.created.fullDistance(from: Date.now, resultIn: resultIn)
        
        if isSameDay == 0 {
            if incrementDay == true {
                apd.count += 1
            }
            AutoFillPerDayStorage.save(apd: apd)
            return apd
        }
        else {
            apd = .init(count: 0, created: .now)
            AutoFillPerDayStorage.save(apd: apd)
            return apd
        }
    }
    
    static func leftAutofills() -> Int {
        let result = MonetizationConfiguration.getAutofillsForAccount() - getUpdatedAutofill(incrementDay: false).count
        
        if result < 0 {
            return 0
        }
        return result
    }
    
    static func reset() {
        AutoFillPerDayStorage.remove()
    }
}

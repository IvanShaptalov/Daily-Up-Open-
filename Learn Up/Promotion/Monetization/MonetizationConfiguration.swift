//
//  MonetizationConfiguration.swift
//  Learn Up
//
//  Created by PowerMac on 25.01.2024.
//

import Foundation


class MonetizationConfiguration {
    static var isPremiumAccount: Bool = false
    
    static var freeAutofillsPerDay: Int = 3
    
    static var premiumAutofillsPerDay: Int = 50
    
    static func getAutofillsForAccount() -> Int{
        if isPremiumAccount{
            return premiumAutofillsPerDay
        }
        return freeAutofillsPerDay
    }
    
    static func fetchFirebase() {
            
        freeAutofillsPerDay = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "freeAutofillsPerDay").numberValue as? Int ?? freeAutofillsPerDay
        
        premiumAutofillsPerDay = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "premiumAutofillsPerDay").numberValue as? Int ?? premiumAutofillsPerDay
    }
}

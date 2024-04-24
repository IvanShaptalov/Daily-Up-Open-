//
//  RateAppProvider.swift
//  Learn Up
//
//  Created by PowerMac on 05.01.2024.
//

import Foundation
import UIKit
import StoreKit


class RateProvider {
    
    
    static private func saveRating(version: String?, isRatedBefore: Bool){
        NSLog("app version: \(version ?? "nil")")
        if appVersion != nil {
            SettingsStorage.saveAppVersion(appVersion: version!)
        }
        
        SettingsStorage.saveRatedBefore(isRatedBefore: isRatedBefore)
        
    }
    
    static private func isNeedToRate() -> Bool {
        let appVersion: String? = SettingsStorage.loadAppVersion()
        let isRated: Bool = SettingsStorage.loadRatedBefore()
        
        if (appVersion == nil){
            NSLog("app version is nil, -> true")
            return true
        }
        
        if (appVersion != appVersion) {
            NSLog("new version, -> true")
            return true
        }
        
        if (!isRated){
            NSLog("not rated, -> true")
            return true
        }
        
        NSLog("app version same, rated true, -> false")
        
        return false
        
        
        
    }
    
    static func rateApp() {
        UIApplication.shared.open(URL(string: FeedBackConfiguration.appStoreURL)!, options: [:], completionHandler: nil)
        AnalyticsManager.shared.logEvent(eventType:.rateDirect)

    }
    
    /// rate app if version not same, or app not rated earlier
    static func rateAppImplicit(view: UIView) {
        if isNeedToRate() {
            if let windowScene = view.window?.windowScene {
                SKStoreReviewController.requestReview(in: windowScene)
                saveRating(version: appVersion, isRatedBefore: true)
                AnalyticsManager.shared.logEvent(eventType:.rateAppImplicitAction)
            }
        }
    }
    
    static private var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

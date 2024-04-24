//
//  Configuration.swift
//  Learn Up
//
//  Created by PowerMac on 27.12.2023.
//

import Foundation


// MARK: - Configuration
class LearnUpConfiguration{
    // MARK: - fetch settings from firebase
    
    
    // MARK: - settings
    static var defaultFromLang: Languages = .Spanish {
        didSet {
            SettingsStorage.saveLang(lang: defaultFromLang, key: StorageConfiguration.fromlang)
        }
    }
    
    /// also used to generate categories from prototype
    static var defaultUILang: Languages = .English {
        didSet {
            SettingsStorage.saveLang(lang: defaultUILang, key: StorageConfiguration.tolang)
        }
    }
    
    static func setUp(){
        defaultFromLang =  SettingsStorage.loadLang(key: StorageConfiguration.fromlang) ?? defaultFromLang
        
        defaultUILang = SettingsStorage.loadLang(key: StorageConfiguration.tolang) ?? defaultUILang
    }
    
    // return
    static var launchedEarlier = SettingsStorage.loadIsFirstLaunch()
    
    
    // MARK: - word placeholder
    static var nothingToLearn = "✅ Done"
    static var addWords = "Add words"
    static var addWordsExpanded = "Add new words to learn"
    static var pronunciation = "dʌn"
    
    // MARK: - autofill Placeholder
    static var autofillPlaceholder = "sorry, can't fill now 😔"
    
    // MARK: - Gpt keys
    
    static var gptToken = ""
    static var gptOrganization = ""
    static var gptModel = "gpt-3.5-turbo-1106"
    
    static var gptModelList: [String] = ["gpt-3.5-turbo-1106",
                                         "gpt-3.5-turbo-0301",
                                         "gpt-3.5-turbo-16k-0613",
                                         "gpt-3.5-turbo-0613"]
    
    static var promptTemplate = ""
    
    static var rateAfterLearnedWords = 0
    
    static var firebaseVolList = ["vol2"]
    
    // MARK: - RevenueCat
    
    static var revenuecat_project_apple_api_key = ""
        
    
    static func switchGptModel(){
        NSLog("now: \(gptModel)")
        let currentIndex = gptModelList.firstIndex(of: gptModel)
        if currentIndex! + 1 < gptModelList.count {
            gptModel = gptModelList[currentIndex! + 1]
        } else {
            gptModel = gptModelList.first!
        }
        NSLog("selected: \(gptModel)")
    }
    
    static var baseCategoryName = "Saved Words"
    
    static var baseCategoryAssetPath = "CollectionDefaultPlaceholder"
    
    
}

// MARK: - URLS
class FeedBackConfiguration {
    static var appStoreURL = ""
    static var mailURL = ""
    static var telegramURL = ""
    static var InstagramURL = ""
    static var TikTokURL = ""
    static var XURL = ""
    
}


// MARK: - Fetching

class ConfigurationFetcher{
    static func fetch(){
        RemoteConfigWrapper.shared.remoteConfig.fetch { (status, error) -> Void in
            if status == .success {
                NSLog("Config fetched!")
                RemoteConfigWrapper.shared.remoteConfig.activate { changed, error in
                    //                        // MARK: - GPT fetching
                    NSLog("Remote Config changed: ")
                    print(changed)
                    
                    //                        if changed {
                    print(RemoteConfigWrapper.shared.remoteConfig.configSettings)
                    print(RemoteConfigWrapper.shared.remoteConfig.configSettings.description)
                    
                    FeedBackConfiguration.appStoreURL = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "appStoreURL").stringValue ?? FeedBackConfiguration.appStoreURL
                    
                    
                    
                    FeedBackConfiguration.mailURL = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "mailURL").stringValue ?? FeedBackConfiguration.mailURL
                    print("***************************************")
                    print(RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "telegramURL").stringValue ?? "nothing")
                    
                    FeedBackConfiguration.telegramURL = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "telegramURL").stringValue ?? FeedBackConfiguration.telegramURL
                    
                    FeedBackConfiguration.XURL = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "XURL").stringValue ?? FeedBackConfiguration.XURL
                    
                    FeedBackConfiguration.TikTokURL = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "TikTokURL").stringValue ?? FeedBackConfiguration.TikTokURL
                    
                    // MARK: - GPT Fetching
                    
                    LearnUpConfiguration.gptToken = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "gptToken").stringValue ?? LearnUpConfiguration.gptToken
                    
                    LearnUpConfiguration.autofillPlaceholder = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "autofillPlaceholder").stringValue ?? LearnUpConfiguration.autofillPlaceholder
                    
                    
                    NSLog("autofillPlaceholder: \(LearnUpConfiguration.autofillPlaceholder)")
                    
                    LearnUpConfiguration.gptOrganization = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "gptOrganization").stringValue ?? LearnUpConfiguration.gptOrganization
                    
                    LearnUpConfiguration.gptModel = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "gptModel").stringValue ?? LearnUpConfiguration.gptModel
                    
                    LearnUpConfiguration.rateAfterLearnedWords = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "rateAfterLearnedWords").numberValue as? Int ?? LearnUpConfiguration.rateAfterLearnedWords
                    
                    
                    
                    NSLog("rate after learned words: \(LearnUpConfiguration.rateAfterLearnedWords)")
                    
                    MonetizationConfiguration.fetchFirebase()
                    
                    let gptModelListRaw = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "gptModelList").stringValue
                    
                    
                    
                    if gptModelListRaw != nil {
                        let splitted = gptModelListRaw?.components(separatedBy: ",")
                        if splitted != nil && !splitted!.isEmpty {
                            LearnUpConfiguration.gptModelList = splitted!
                        }
                    }
                    
                    // MARK: - Firebase vol list
                    let firebaseVolRaw = RemoteConfigWrapper.shared.remoteConfig.configValue(forKey: "firebaseVolList").stringValue
                    
                    
                    
                    if firebaseVolRaw != nil {
                        let splitted = firebaseVolRaw?.components(separatedBy: ",")
                        if splitted != nil && !splitted!.isEmpty {
                            LearnUpConfiguration.firebaseVolList = splitted!
                        }
                    }
                }
                
            } else {
                NSLog("Config not fetched")
                NSLog("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
}

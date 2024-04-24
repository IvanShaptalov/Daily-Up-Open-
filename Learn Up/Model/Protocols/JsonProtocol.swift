//
//  JsonProtocol.swift
//  Learn Up
//
//  Created by PowerMac on 02.01.2024.
//

import Foundation

// MARK: - Words
protocol WordsJsonProtocol{
    static func toJson(_ words: [Word]) -> String
    
    static func fromJson(wordListJson: String) -> [Word]
}

// MARK: - Autofill per day

protocol AutofillPerDayJsonProtocol {
    static func toJson(_ apd: AutofillPerDay) -> String
    
    static func fromJson(apdJson: String) -> AutofillPerDay?
}

// MARK: - Daystreak
protocol DayStreakJsonProtocol {
    static func toJson(_ apd: DayStreak) -> String
    
    static func fromJson(apdJson: String) -> DayStreak?
}


// MARK: - Settings
protocol SettingsJsonProtocol {
    static func toJson(_ settings :LocalizationSettings) -> String
    
    static func fromJson(settingJson: String) -> LocalizationSettings
}

// MARK: - Word Learner
protocol WordLearnerJsonProtocol {
    static func toJson(_ learner: WordLearner?) -> String
    
    static func fromJson(learnerJson: String) -> WordLearner?
    
}

// MARK: - List link
protocol LanguageLinkListProtocol{
    static func toJson(_ words: LanguageLinkList) -> String
    
    static func fromJson(langListJson: String) -> LanguageLinkList
}

// MARK: - Language Link
protocol LanguageLinkProtocol {
    static func toJson(_ words: LanguageLink) -> String
    
    static func fromJson(langListJson: String) -> LanguageLink
}

// MARK: - Word Category

protocol CategoryWordJsonProtocol{
    static func toJson(_ category: CategoryWords) -> String
    
    static func fromJson(wordCategoryJson: String) -> CategoryWords
}

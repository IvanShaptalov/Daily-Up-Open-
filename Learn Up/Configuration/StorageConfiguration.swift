//
//  StorageConfiguration.swift
//  Learn Up
//
//  Created by PowerMac on 02.01.2024.
//

import Foundation

public class StorageConfiguration {
    static let storage = UserDefaults(suiteName: "group.wvantage")
    static let wordsKey = "words"
    static let learnerKey = "selector"
    static let configurationKey = "configuration"
    static let fromlang = "fromlang"
    static let tolang = "tolang"
    static let launchedBefore = "fLaunch"
    static let ratedBefore = "ratedBefore"
    static let appVersion = "appVersion"
    static let wordCategoryLinkListKey = "wordCategoryLinkList"
    static let selectedCategory = "selectedCategory"
    static let savedCategoryKey = "_"
    static let categoryPrototypeLinkListKey = "categoryPrototypeLinkList"
    static let dayStreakKey = "dayStreakKey"

    static let autofillCounterKey = "autofillCounterKey"
}

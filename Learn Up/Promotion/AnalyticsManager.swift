//
//  AnalyticsManager.swift
//  Learn Up
//
//  Created by PowerMac on 14.01.2024.
//

import Foundation
import FirebaseAnalytics


final class AnalyticsManager {
    private init() {}
    static let shared = AnalyticsManager()
    
    public func logEvent(eventType: EventType, parameters:  [String: Any]? = nil) {
        Analytics.logEvent(eventType.rawValue, parameters: parameters)
    }
}


enum EventType: String {
    case
    translateWord = "translate_word",
    autofillWord = "autofill",
    selectLearnLang = "select_learn_lang",
    selectUILang = "select_ui_lang",
    selectCategory = "select_category",
    addWordAction = "add_word",
    editWordAction = "edit_word",
    deleteWordAction = "delete_word",
    rateAppImplicitAction = "rate_app_autofill",
    openWidgetTutorial = "open_widget_tutorial",
    wordLearned = "word_learned",
    wordLearnedCounted = "word_learned_counted",
    setWidget = "set_widget",
    rateDirect = "rate_direct",
    localCategorySelected = "local_category_selected",
    discoverCategorySelected = "discover_category_selected"
    
    
}

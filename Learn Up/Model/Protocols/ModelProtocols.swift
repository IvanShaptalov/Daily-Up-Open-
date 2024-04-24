//
//  ModelProtocols.swift
//  Learn Up
//
//  Created by PowerMac on 02.01.2024.
//

import Foundation

// MARK: - Word Protocol
protocol WordProtocol{
    var fromLang: Languages {get set }
    
    var toLang: Languages {get set}
    
    var word: String {get set}
    
    var translation: String {get set}
    
    var meaning: String {get set}
    
    var pronunciation: String {get set}
    
    var trDate: Date {get set}
    
    var isLearned: Bool {get set}
    
    var id: String {get}
    
    /// origin means that translation created on origin language, for example, we translate english to french
    /// word cheval: translation - horse, but translationOrigin - cheval, for reusing in other collections
    var translationOrigin: String? {get set}
    
    /// origin meaning , same as translationOrigin clue
    var meaningOrigin: String? {get set}
   
    /// origin pronunciation, same as translationOrigin clue
    var pronunciationOrigin: String? {get set}
  
    /// links to word analog in different languages
    var languageLinkList:  LanguageLinkList? {get set}
}

// MARK: - LocalizationSettins
protocol LocalizationSettingsProtocol{
    var defaultFromLang: Languages {get set}
    var defaultToLang: Languages {get set}
    var uiLanguage: Languages {get set}
}

// MARK: - WordSelector
protocol WordSelectorProtocol {
    static func setUpWord(words: [WordProtocol], wordLearner: inout WordLearner?) -> [String]
}


// MARK: - Catalog

protocol WordCategoryProtocol {
    var title: String {get set}
    var language: Languages {get set}
    var id: String {get set}
    var wordList: [Word] {get set}
    var assetPath: String {get set}
    
    func fetchWords()
}

protocol CategorySelectorProtocol {
    static func setUpWordCategory() -> CategoryWords
}

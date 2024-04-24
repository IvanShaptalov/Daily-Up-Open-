//
//  Catalog.swift
//  Learn Up
//
//  Created by PowerMac on 12.01.2024.
//

import Foundation


struct CategoryWords: WordCategoryProtocol, Hashable, Codable{
    static func == (lhs: CategoryWords, rhs: CategoryWords) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    /// fetch from firebase
    func fetchWords() {
        
    }
    
    var title: String
    
    var language: Languages
    
    var id: String
    
    var isPremium: Bool
    
    var assetPath: String
    
    var wordList: [Word] = []
    
    init(title: String, language: Languages, id: String, wordList: [Word] = [], isPremium: Bool, assetPath: String) {
        self.title = title
        self.language = language
        self.id = id
        self.wordList = wordList
        self.isPremium = isPremium
        self.assetPath = assetPath
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(language)
        hasher.combine(wordList.count)
        hasher.combine(isPremium)
    }
    
    enum ConfigKeys: String, CodingKey {
        case id
        case title
        case language
        case wordList
        case isPremium
        case assetPath
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ConfigKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id)!
        self.language = try values.decodeIfPresent(Languages.self, forKey: .language)!
        self.title = try values.decodeIfPresent(String.self, forKey: .title)!
        self.wordList = try values.decodeIfPresent([Word].self, forKey: .wordList) ?? []
        self.isPremium = try values.decodeIfPresent(Bool.self, forKey: .isPremium)!
        self.assetPath = try values.decodeIfPresent(String.self, forKey: .assetPath) ?? LearnUpConfiguration.baseCategoryAssetPath
    }
    
    static func instanceEmptySaved() -> CategoryWords {
        return CategoryWords(title: LearnUpConfiguration.baseCategoryName, language: .English, id: StorageConfiguration.savedCategoryKey, wordList: [], isPremium: false, assetPath: LearnUpConfiguration.baseCategoryAssetPath)
    }
    
    
}





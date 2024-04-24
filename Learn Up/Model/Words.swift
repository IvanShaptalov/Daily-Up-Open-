//
//  Words.swift
//  Learn Up
//
//  Created by PowerMac on 25.12.2023.
//

import Foundation


struct Word : WordProtocol, Hashable{
    // MARK: - Optional for memorize words in collections
    var languageLinkList: LanguageLinkList?
    
    var translationOrigin: String?
    
    var meaningOrigin: String?
    
    var pronunciationOrigin: String?
    
    var id: String
    
    var fromLang: Languages
    
    var toLang: Languages
    
    var word: String
    
    var translation: String
    
    var meaning: String
    
    var pronunciation: String
    
    var trDate: Date
    
    var isLearned: Bool
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(word)
        hasher.combine(pronunciation)
        hasher.combine(translation)
        hasher.combine(isLearned)
    }
    
    
    
    
    init(id: String, fromLang: Languages, toLang: Languages, word: String, translation: String, meaning: String, pronunciation: String, trDate: Date, isLearned: Bool, translationOrigin: String? = nil, meaningOrigin: String? = nil, pronunciationOrigin: String? = nil, languageLinkList: LanguageLinkList? = nil) {
        self.id = id
        self.fromLang = fromLang
        self.toLang = toLang
        self.word = word
        self.translation = translation
        self.meaning = meaning
        self.pronunciation = pronunciation
        self.trDate = trDate
        self.isLearned = isLearned
        self.translationOrigin = translationOrigin
        self.meaningOrigin = meaningOrigin
        self.pronunciationOrigin = pronunciationOrigin
        self.languageLinkList = languageLinkList
    }
    
    
}

extension Word: Codable {
    enum ConfigKeys: String, CodingKey {
        case id
        case fromLang
        case toLang
        case word
        case translation
        case meaning
        case pronunciation
        case trDate
        case isLearned
        case translationOrigin
        case meaningOrigin
        case pronunciationOrigin
        case languageLinkList
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: ConfigKeys.self)
        self.id = try values.decodeIfPresent(String.self, forKey: .id)!
        self.fromLang = try values.decodeIfPresent(Languages.self, forKey: .fromLang)!
        self.toLang = try values.decodeIfPresent(Languages.self, forKey: .toLang)!
        self.word = try values.decodeIfPresent(String.self, forKey: .word)!
        self.translation = try values.decodeIfPresent(String.self, forKey: .translation)!
        self.meaning = try values.decodeIfPresent(String.self, forKey: .meaning) ?? ""
        self.pronunciation = try values.decodeIfPresent(String.self, forKey: .pronunciation) ?? ""
        self.trDate = try values.decodeIfPresent(Date.self, forKey: .trDate) ?? Date.now
        self.isLearned = try values.decodeIfPresent(Bool.self, forKey: .isLearned)!
        self.pronunciationOrigin = try values.decodeIfPresent(String.self, forKey: .pronunciationOrigin)
        self.translationOrigin = try values.decodeIfPresent(String.self, forKey: .translationOrigin)
        self.meaningOrigin = try values.decodeIfPresent(String.self, forKey: .meaningOrigin)
        self.languageLinkList = try values.decodeIfPresent(LanguageLinkList.self, forKey: .languageLinkList)
    }
}

class WordValidator {
    var fromLang: Languages?
    
    var toLang: Languages?
    
    var word: String?
    
    var translation: String?
    
    var meaning: String?
    
    var pronunciation: String?
    
    var trDate: Date?
    
    var isLearned: Bool?
    
    var isValid: Bool = false
    
    var id: String?
    
    init (fromL: Languages?, toL: Languages?,
          word: String?,
          translation: String?,
          meaning: String?,
          pronunciation: String?,
          trDate: Date?,
          isLearned: Bool?,
          id: String?){
        self.fromLang = fromL
        self.toLang = toL
        self.word = word
        self.translation = translation
        self.meaning = meaning
        self.pronunciation = pronunciation
        self.trDate = trDate
        self.isLearned = isLearned
        self.id = id
        
    }
    
    
    
    static var wordError: String = "enter word"
    
    static var translationError: String = "enterTranslation"
    
    static var validateStatusSuccess: String = "added succesfully"
    
    
    
    
    func validate() -> (String, WordProtocol?) {
        let fromLang = fromLang ?? LearnUpConfiguration.defaultFromLang
        
        let toLang = toLang ?? LearnUpConfiguration.defaultUILang
        
        let word = word
        
        if word == nil || word!.isEmpty {
            return (WordValidator.wordError, nil)
        }
        
        let translation = translation
        
        
        if translation == nil || translation!.isEmpty  {
            return (WordValidator.translationError, nil)
        }
        
        var meaning = meaning
        
        if meaning == nil || meaning!.isEmpty {
            meaning =  "add meaning via editing word"
        }
        
        var pronunciation = pronunciation
        
        if pronunciation == nil || pronunciation!.isEmpty {
            pronunciation = "add pronunciation via editing word"
        }
        
        
        let validatedId = id ?? UUID().uuidString
        
        let trDate = trDate ?? Date.now
        
        let isLearned = isLearned ?? false
        
        let wordObj: Word? = Word(id: validatedId, fromLang: fromLang, toLang: toLang, word: word!, translation: translation!, meaning: meaning!, pronunciation: pronunciation!,
                                  trDate: trDate,
                                  isLearned: isLearned)
        
        self.isValid = true
        
        return (WordValidator.validateStatusSuccess, wordObj)
    }
}

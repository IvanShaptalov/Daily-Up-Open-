//
//  LanguageLinkList.swift
//  Learn Up
//
//  Created by PowerMac on 12.01.2024.
//

import Foundation


class LanguageLinkList: Codable, Equatable, Hashable {
    static func == (lhs: LanguageLinkList, rhs: LanguageLinkList) -> Bool {
        lhs.linkId == rhs.linkId
    }
        
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.linkId)
    }
    
    func getLangLink(lang: Languages) -> LanguageLink? {
        switch lang {
        case .Arabic:
            return self.toArabic
        case .Chinese:
            return self.toChinese
        case .English:
            return self.toEnglish
        case .French:
            return self.toFrench
        case .Georgian:
            return self.toSakartvelo
        case .German:
            return self.toGerman
        case .Hindi:
            return self.toHindi
        case .Japanese:
            return self.toJapanese
        case .Portuguese:
            return self.toPortuguese
        case .Russian:
            return self.toRussian
        case .Spanish:
            return self.toSpanish
        case .Ukrainian:
            return self.toUkrainian
        }
        
    }
    
    
    var linkId: String
    var toSpanish : LanguageLink?
    var toFrench: LanguageLink?
    var toChinese: LanguageLink?
    var toGerman: LanguageLink?
    var toPortuguese: LanguageLink?
    var toRussian: LanguageLink?
    var toArabic: LanguageLink?
    var toEnglish: LanguageLink?
    var toJapanese: LanguageLink?
    var toHindi: LanguageLink?
    var toUkrainian: LanguageLink?
    var toSakartvelo: LanguageLink?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.linkId = try container.decode(String.self, forKey: .linkId)
        self.toSpanish = try container.decodeIfPresent(LanguageLink.self, forKey: .toSpanish)
        self.toFrench = try container.decodeIfPresent(LanguageLink.self, forKey: .toFrench)
        self.toChinese = try container.decodeIfPresent(LanguageLink.self, forKey: .toChinese)
        self.toGerman = try container.decodeIfPresent(LanguageLink.self, forKey: .toGerman)
        self.toPortuguese = try container.decodeIfPresent(LanguageLink.self, forKey: .toPortuguese)
        self.toRussian = try container.decodeIfPresent(LanguageLink.self, forKey: .toRussian)
        self.toArabic = try container.decodeIfPresent(LanguageLink.self, forKey: .toArabic)
        self.toEnglish = try container.decodeIfPresent(LanguageLink.self, forKey: .toEnglish)
        self.toJapanese = try container.decodeIfPresent(LanguageLink.self, forKey: .toJapanese)
        self.toHindi = try container.decodeIfPresent(LanguageLink.self, forKey: .toHindi)
        self.toUkrainian = try container.decodeIfPresent(LanguageLink.self, forKey: .toUkrainian)
        self.toSakartvelo = try container.decodeIfPresent(LanguageLink.self, forKey: .toSakartvelo)
    }
    
    init(linkId: String, toSpanish: LanguageLink? = nil, toFrench: LanguageLink? = nil, toChinese: LanguageLink? = nil, toGerman: LanguageLink? = nil, toPortuguese: LanguageLink? = nil, toRussian: LanguageLink? = nil, toArabic: LanguageLink? = nil, toEnglish: LanguageLink? = nil, toJapanese: LanguageLink? = nil, toHindi: LanguageLink? = nil, toUkrainian: LanguageLink? = nil, toSakartvelo: LanguageLink? = nil) {
        self.linkId = linkId
        self.toSpanish = toSpanish
        self.toFrench = toFrench
        self.toChinese = toChinese
        self.toGerman = toGerman
        self.toPortuguese = toPortuguese
        self.toRussian = toRussian
        self.toArabic = toArabic
        self.toEnglish = toEnglish
        self.toJapanese = toJapanese
        self.toHindi = toHindi
        self.toUkrainian = toUkrainian
        self.toSakartvelo = toSakartvelo
    }
}

class LanguageLink:  Codable, Equatable, Hashable  {
    static func == (lhs: LanguageLink, rhs: LanguageLink) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.toCategory)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.toCategory = try container.decodeIfPresent(String.self, forKey: .toCategory)
    }
    
    init(toCategory: String? = nil) {
        self.toCategory = toCategory
    }
    
    var toCategory: String?
}

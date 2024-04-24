//
//  WordAssetProtocol.swift
//  Learn Up
//
//  Created by PowerMac on 17.01.2024.
//

import Foundation



protocol WordAssetProtocol {
    static var wordCategory: CategoryWords {get set}
    
    static func loadWordList() -> [Word]
}


// MARK: - Вітаю
/// hello language link
var demoCategoriesLinkVol1: LanguageLinkList = LanguageLinkList(
    linkId: "AB971D26-8AF5-4DB8-BEB4-359437A8CC43",
    //1
    toSpanish: LanguageLink(
        toCategory: "spanishDemo"
    ),
    //2
    toFrench: LanguageLink(
        toCategory: "frenchDemo"
    ),
    //3
    toChinese: LanguageLink(
        toCategory: "chineseDemo"
    ),
    //4
    toGerman: LanguageLink(
        toCategory: "germanDemo"
    ),
    //5
    toPortuguese: LanguageLink(
        toCategory: "portugueseDemo"
    ),
    //6
    toRussian: LanguageLink(
        toCategory: "russianDemo"
    ),
    //7
    toArabic: LanguageLink(
        toCategory: "arabicDemo"
    ),
    //8
    toEnglish: LanguageLink(
        toCategory: "englishDemo"
    ),
    //9
    toJapanese: LanguageLink(
        toCategory: "japaneseDemo"
    ), 
    //10
    toHindi: LanguageLink(
        toCategory: "hindiDemo"
    ),
    //11
    toUkrainian: LanguageLink(
        toCategory: "ukrainianDemo"
    ),
    //12
    toSakartvelo: LanguageLink(
        toCategory: "sakartveloDemo"
    )
)



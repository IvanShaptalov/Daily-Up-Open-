//
//  Learn_UpTests.swift
//  Learn UpTests
//
//  Created by PowerMac on 23.12.2023.
//

import XCTest
@testable import Learn_Up

final class Learn_UpTests: XCTestCase {
    
    var languageRawList: [String] = []
    
    var languageList: [Languages] = []
    
    var languageListWithEmoji: [String] = []
    
    var fields: [Any] = []
    
    var emojiList: [String] = []
    
    var wordList: [WordProtocol] = [
        Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "1", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false),
        Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false),
        Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "3", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false)]
    
    var wordLearner: WordLearner?
    
    
    
    
    /// check equality of any value if it hashable
    func equals(_ x : Any?, _ y : Any?) -> Bool {
        if x == nil && y == nil{
            return true
        }
        guard x is AnyHashable else { return false }
        guard y is AnyHashable else { return false }
        return (x as! AnyHashable) == (y as! AnyHashable)
    }
    
    override func setUpWithError() throws {
        languageRawList = [
            "spanish", "french", "Chinese", "german", "portuguese", "russian", "Arabic", "englIsh", "japanese", "hindi", "Ukrainian", "georgian"
        ]
        
        languageListWithEmoji = ["spanish 🇪🇸", "french 🇫🇷", "Chinese 🇨🇳", "german 🇩🇪", "portuguese 🇵🇹", "russian 🇷🇺", "Arabic 🇦🇪", "englIsh 🇬🇧", "japanese 🇯🇵", "hindi 🇮🇳", "Ukrainian 🇺🇦", "georgian 🇬🇪"]
        
        emojiList = Languages.emojiList
        
        languageList = [.Spanish,.French,.Chinese,.German,.Portuguese,.Russian,.Arabic,.English,.Japanese,.Hindi,.Ukrainian, .Georgian]
        
        fields = [Languages.English,
                  Languages.Ukrainian,
                  "hello",
                  "привіт",
                  "hello is a greeting in a many countries",
                  "pry vit",
                  true]
        
    }
    
    override func tearDownWithError() throws {
        languageList.removeAll()
        languageRawList.removeAll()
        fields.removeAll()
        emojiList.removeAll()
        languageListWithEmoji.removeAll()
    }
    // MARK: - Word Category Json
    func testWordCategoryJson() throws {
        let word1 = Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false, translationOrigin: "hello", meaningOrigin: "origin meaning", pronunciationOrigin: "origin pronunciation", languageLinkList: LanguageLinkList(linkId: UUID().uuidString, toSpanish: LanguageLink(toCategory: "category"), toFrench: LanguageLink(toCategory: "category"), toChinese: LanguageLink(toCategory: "category"), toGerman: LanguageLink(toCategory: "category"), toPortuguese: LanguageLink(toCategory: "category"), toRussian: LanguageLink(toCategory: "category"), toArabic: LanguageLink(toCategory: "category"), toEnglish: LanguageLink(toCategory: "category"), toJapanese: LanguageLink(toCategory: "category"), toHindi: LanguageLink(toCategory: "category"),
                                                                                                                                                                                                                                                                                                  toUkrainian: LanguageLink(toCategory: "category")))
        
        let word2 = Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false, translationOrigin: "hello", meaningOrigin: "origin meaning", pronunciationOrigin: "origin pronunciation", languageLinkList: LanguageLinkList(linkId: UUID().uuidString, toSpanish: LanguageLink(toCategory: "category"), toFrench: LanguageLink(toCategory: "category"), toChinese: LanguageLink(toCategory: "category"), toGerman: LanguageLink(toCategory: "category"), toPortuguese: LanguageLink(toCategory: "category"), toRussian: LanguageLink(toCategory: "category"), toArabic: LanguageLink(toCategory: "category"), toEnglish: LanguageLink(toCategory: "category"), toJapanese: LanguageLink(toCategory: "category"), toHindi: LanguageLink(toCategory: "category"),
                                                                                                                                                                                                                                                                                                  toUkrainian: LanguageLink(toCategory: "category")))
    
        let wordCategory = CategoryWords(title: "testCategory", language: .Arabic, id: UUID().uuidString, wordList: [word1, word2], isPremium: true, assetPath: LearnUpConfiguration.baseCategoryAssetPath)
        
        let jsonString: String = CategoryWordJsonCoder.toJson(wordCategory)
        
        let wordCategory2 = CategoryWordJsonCoder.fromJson(wordCategoryJson: jsonString)
        
        XCTAssertEqual(wordCategory.wordList.first!.languageLinkList,
                       wordCategory2.wordList.first!.languageLinkList)
        
        XCTAssertEqual(wordCategory.wordList.first!.meaningOrigin, 
                       wordCategory2.wordList.first!.meaningOrigin)
        
        XCTAssertEqual(wordCategory.wordList.first!.translationOrigin,
                       wordCategory2.wordList.first!.translationOrigin)
        
        XCTAssertEqual(wordCategory.wordList.first!.pronunciationOrigin,
                       wordCategory2.wordList.first!.pronunciationOrigin)
        
        XCTAssertEqual(wordCategory, wordCategory2)
        
    }
    // MARK: - Origin word
    func testWordJsonOrigin() throws {
        let word1 = Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false, translationOrigin: "hello", meaningOrigin: "origin meaning", pronunciationOrigin: "origin pronunciation", languageLinkList: LanguageLinkList(linkId: UUID().uuidString, toSpanish: LanguageLink(toCategory: "category"), toFrench: LanguageLink(toCategory: "category"), toChinese: LanguageLink(toCategory: "category"), toGerman: LanguageLink(toCategory: "category"), toPortuguese: LanguageLink(toCategory: "category"), toRussian: LanguageLink(toCategory: "category"), toArabic: LanguageLink(toCategory: "category"), toEnglish: LanguageLink(toCategory: "category"), toJapanese: LanguageLink(toCategory: "category"), toHindi: LanguageLink(toCategory: "category"),
                                                                                                                                                                                                                                                                                                  toUkrainian: LanguageLink(toCategory: "category")))
        
        let jsonString: String = WordListJsonCoder.toJson([word1])
        
        let word2 = WordListJsonCoder.fromJson(wordListJson: jsonString).first!
        
        XCTAssertEqual(word1.languageLinkList, word2.languageLinkList)
        XCTAssertEqual(word1.meaningOrigin, word2.meaningOrigin)
        XCTAssertEqual(word1.translationOrigin, word2.translationOrigin)
        XCTAssertEqual(word1.pronunciationOrigin, word2.pronunciationOrigin)
        
    }
    
    // MARK: - Language list link json
    
    func testLanguageListLinkJsonNil() {
        let listLink = LanguageLinkList(linkId: UUID().uuidString)
        
        let jsonString: String = LanguageListLinkCoder.toJson(listLink)
        
        let langLinkList2 = LanguageListLinkCoder.fromJson(langListJson: jsonString)
        
        XCTAssertEqual(listLink, langLinkList2)
        
    }
    
    func testLanguageListLinkJson() {
        let listLink = LanguageLinkList(linkId: UUID().uuidString, toSpanish: LanguageLink(toCategory: "category"), toFrench: LanguageLink(toCategory: "category"), toChinese: LanguageLink(toCategory: "category"), toGerman: LanguageLink(toCategory: "category"), toPortuguese: LanguageLink(toCategory: "category"), toRussian: LanguageLink(toCategory: "category"), toArabic: LanguageLink(toCategory: "category"), toEnglish: LanguageLink(toCategory: "category"), toJapanese: LanguageLink(toCategory: "category"), toHindi: LanguageLink(toCategory: "category"),
                                        toUkrainian: LanguageLink(toCategory: "category"))
        
        let jsonString: String = LanguageListLinkCoder.toJson(listLink)
        
        let langLinkList2 = LanguageListLinkCoder.fromJson(langListJson: jsonString)
        
        XCTAssertEqual(listLink, langLinkList2)
        
    }
    // MARK: - Language Link Json
    func testLanguageLinkJson() {
        let langLink = LanguageLink(toCategory: "category")
        
        let jsonString: String = LanguageLinkCoder.toJson(langLink)
        
        let langLink2 = LanguageLinkCoder.fromJson(langListJson: jsonString)
        
        XCTAssertEqual(langLink, langLink2)
    }
    
    func testLanguageLinkJsonNil() {
        let langLink = LanguageLink()
        
        let jsonString: String = LanguageLinkCoder.toJson(langLink)
        
        let langLink2 = LanguageLinkCoder.fromJson(langListJson: jsonString)
        
        XCTAssertEqual(langLink, langLink2)
        
        
    }
    
    
    
    // MARK: - Test Word
    func testWordHash() throws {
        let word1 = Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "gel", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  true)
        
        let word2 = word1
        
        let word3 = Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "ge22l", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned: true)
        
        XCTAssertEqual(word1, word2)
        XCTAssertNotEqual(word1, word3)
    }
    
    
    func testWordValidation() throws {
        let validator = WordValidator(fromL: Languages.English, toL: Languages.Ukrainian, word: "hello", translation: "привіт", meaning: "hello is a greeting in a many countries", pronunciation: "pry vit", trDate: Date.now, isLearned: true, id: UUID().uuidString)
        let wordTuple1: (String, WordProtocol?) = validator.validate()
        
        XCTAssert(wordTuple1.0 == WordValidator.validateStatusSuccess)
        XCTAssert(wordTuple1.1 != nil)
        
        XCTAssertTrue(validator.isValid)
        
        let wordFields: [Any?] = [wordTuple1.1?.fromLang,
                                  wordTuple1.1?.toLang,
                                  wordTuple1.1?.word,
                                  wordTuple1.1?.translation,
                                  wordTuple1.1?.meaning,
                                  wordTuple1.1?.pronunciation,
                                  wordTuple1.1?.isLearned,
        ]
        
        for (i, value) in zip (wordFields.indices, wordFields){
            XCTAssert(equals(value, fields[i]))
        }
        
    }
    
    // MARK: - Test Languages
    func testToEmoji() throws {
        for (i, lang) in zip (languageList.indices, languageList){
            XCTAssertEqual(Languages.langToEmoji(lang: lang), emojiList[i])
        }
    }
    
    func testRemoveEmoji() throws {
        for (i, rawLang) in zip (languageList.indices, languageRawList){
            XCTAssertEqual(rawLang.lowercased(), Languages.removeEmoji(lang: languageListWithEmoji[i]))
        }
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    // MARK: - Selector testings
    func testLearnerAndWordsNotNil() throws {
        wordLearner = WordLearner(word: wordList.first(where: {!$0.isLearned}) as! Word)
        
        let instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNotNil(wordLearner)
        XCTAssertNotNil(wordList)
        XCTAssertNotNil(instructions)
    }
    
    func testLearnerNilWordsNot() throws {
        wordLearner = nil
        
        let instructions: [String] = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNotNil(wordLearner)
        XCTAssertNotNil(wordList)
        XCTAssertNotNil(instructions)
    }
    
    func testWordsInteraction(){
        wordList =  [Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "1", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false),
                     Word(
                        id: UUID().uuidString,
                        fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false),
                     Word(
                        id: UUID().uuidString,
                        fromLang: .Arabic, toLang: .English, word: "3", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false)]
        
        var instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertEqual(instructions[0], "🇦🇪 1")
        
        wordList.removeFirst()
        
        instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertTrue(instructions[0] == "🇦🇪 2")
        
        wordList[1].isLearned = true
        
        wordList[0].isLearned = true
        
        instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNil(wordLearner)
        
        wordList[0].isLearned = false
        
        instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNotNil(wordLearner)
        
        wordList.removeAll()
        
        instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNil(wordLearner)
        
        
        
        
    }
    
    func testLearnerNotNilWordsUnlearnedEmpty() throws {
        wordLearner = WordLearner(word: wordList.first(where: {!$0.isLearned}) as! Word)
        
        wordList.removeAll()
        
        let instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNil(wordLearner)
        XCTAssertTrue(wordList.isEmpty)
        XCTAssertNotNil(instructions)
    }
    
    func testLearnerNilWordsNil() throws {
        wordLearner = nil
        wordList.removeAll()
        
        let instructions = WordSelector.setUpWord(words: wordList, wordLearner: &wordLearner)
        
        XCTAssertNil(wordLearner)
        XCTAssertTrue(wordList.isEmpty)
        XCTAssertNotNil(instructions)
        
    }
    
    // MARK: Test Json coding
    
    func testWordsJsonCoding() throws {
        let word1 = Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false)
        
        let jsonString: String = WordListJsonCoder.toJson([word1])
        
        let word2 = WordListJsonCoder.fromJson(wordListJson: jsonString).first!
        
        XCTAssertEqual(word1, word2)
        
    }
    func testLearnerJsonCoding() throws {
        let learner1 = WordLearner(word: Word(
            id: UUID().uuidString,
            fromLang: .Arabic, toLang: .English, word: "2", translation: "ola", meaning: "", pronunciation: "", trDate: Date.now, isLearned:  false))
        
        print(learner1.wordId)
        
        let learnerJson = WordLearnerJsonCoder.toJson(learner1)
        
        let learner2 = WordLearnerJsonCoder.fromJson(learnerJson: learnerJson)
        
        XCTAssertEqual(learner1.wordId, learner2?.wordId)
    }
    
    func testNilLearnerJsonCoding() throws {
        let learner1: WordLearner? = nil
        
        let learnerJson = WordLearnerJsonCoder.toJson(learner1)
        
        let learner2 = WordLearnerJsonCoder.fromJson(learnerJson: learnerJson)
        
        XCTAssertNil(learner2)
    }
    
    func testSettingsJsonCoding() throws {
        let setting1 = LocalizationSettings(defaultFromLang: .English, defaultToLang: .Ukrainian, uiLanguage: .English)
        
        let settingJson = SettingsJsonCoder.toJson(setting1)
        
        let setting2 = SettingsJsonCoder.fromJson(settingJson: settingJson)
        
        XCTAssertEqual(setting1.uiLanguage, setting2.uiLanguage)
    }
    
    // MARK: - Word Category Storage
    func testMetaCategorySaving_Loading() throws {
        let c = CategoryWords.instanceEmptySaved()
        CategoryWordStorage.saveJson(category: c)
        let cJson = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
        let newC = CategoryWordJsonCoder.fromJson(wordCategoryJson: cJson!)
        XCTAssertEqual(c, newC)
    }
    
    // MARK: - Word Category Storage LINKS
    func testCategoryLinkSavingLoading() throws {
        CategoryWordStorage.clearAllCategoryLinks()
        var links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.isEmpty == true, "links is not empty")
        
        var c = CategoryWords.instanceEmptySaved()
        CategoryWordStorage.saveJson(category: c)
        let cJson = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
        let newC = CategoryWordJsonCoder.fromJson(wordCategoryJson: cJson!)
        XCTAssertEqual(c, newC)
        
        links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.count == 1, "links is not created")
        
        c.id = "test1"
        CategoryWordStorage.saveJson(category: c)
        CategoryWordStorage.saveJson(category: c)
        
        links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.count == 2, "links is not created")
        links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links[1]["id"] as! String == "test1", "links is valid")
    }
    
    func testCategoryLinkDeleting() throws {
        CategoryWordStorage.clearAllCategoryLinks()
        var links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.isEmpty == true, "links is not empty")
        
        let c = CategoryWords.instanceEmptySaved()
        CategoryWordStorage.saveJson(category: c)
        let cJson = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
        let newC = CategoryWordJsonCoder.fromJson(wordCategoryJson: cJson!)
        XCTAssertEqual(c, newC)
        
        links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.count == 1, "links is not created")
        
        CategoryWordStorage.removeCollection(category: c)
        links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.isEmpty == true, "links is not empty")
        let cJsonNil = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
        XCTAssertNil(cJsonNil)
    }
    
    func testLoadingCategoryViaLink() throws {
        CategoryWordStorage.clearAllCategoryLinks()
        let links = CategoryWordStorage.loadAllCategoryLinks()
        XCTAssert(links.isEmpty == true, "links is not empty")
        
        let c = CategoryWords.instanceEmptySaved()
        CategoryWordStorage.saveJson(category: c)
        let cJson = CategoryWordStorage.loadJson(key: CategoryWordStorage.loadAllCategoryLinks().first!["id"] as! String)
        
        let newC = CategoryWordJsonCoder.fromJson(wordCategoryJson: cJson!)
        
        XCTAssertEqual(newC, c)
    }
    // MARK: - AUTOFILL
    
    func testSavingAutofill() {
        AutofillUpdateProvider.reset()
        XCTAssertEqual(AutofillUpdateProvider.leftAutofills(), 3)
        
        var _ = AutofillUpdateProvider.saveAutofill()
        XCTAssertEqual(AutofillUpdateProvider.leftAutofills(), 2)
        
        var _ = AutofillUpdateProvider.saveAutofill()
        XCTAssertEqual(AutofillUpdateProvider.leftAutofills(), 1)
        
        var _ = AutofillUpdateProvider.saveAutofill()
        XCTAssertEqual(AutofillUpdateProvider.leftAutofills(), 0)
        
        var _ = AutofillUpdateProvider.saveAutofill()
        XCTAssertEqual(AutofillUpdateProvider.leftAutofills(), 0)
        
        
        
        AutofillUpdateProvider.reset()
        XCTAssertEqual(AutofillUpdateProvider.leftAutofills(), 3)
    }
    
    func testAutofillUpdateIfOld() {
        AutofillUpdateProvider.reset()
        XCTAssertEqual(MonetizationConfiguration.freeAutofillsPerDay, AutofillUpdateProvider.leftAutofills())
    }
    
//    // MARK: - DAYSTREAK
//    func testDayStreak() {
//        
//        DayStreakUpdateProvider.reset()
//        DayStreakUpdateProvider.resultIn = .second
//        sleep(1)
//        XCTAssertEqual(DayStreakUpdateProvider.getUpdatedDayStreak(incrementDay: true).count, 2)
//        sleep(1)
//        XCTAssertEqual(DayStreakUpdateProvider.getUpdatedDayStreak(incrementDay: true).count, 3)
//        sleep(1)
//        XCTAssertEqual(DayStreakUpdateProvider.getUpdatedDayStreak(incrementDay: true).count, 4)
//        sleep(2)
//        XCTAssertEqual(DayStreakUpdateProvider.getUpdatedDayStreak(incrementDay: true).count, 1)
//        sleep(1)
//        XCTAssertEqual(DayStreakUpdateProvider.getUpdatedDayStreak(incrementDay: true).count, 2)
//    }
}




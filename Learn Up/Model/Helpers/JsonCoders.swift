//
//  JsonConverter.swift
//  Learn Up
//
//  Created by PowerMac on 02.01.2024.
//

import Foundation

// MARK: - Words
class WordListJsonCoder : WordsJsonProtocol {
    static func toJson(_ words: [Word]) -> String{
        do {
            return String(data: try JSONEncoder().encode<[Word]>(words), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(wordListJson: String) -> [Word] {
        var wordList: [Word] = []
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = wordListJson.data(using: .utf8)!
            wordList = try jsonDecoder.decode([Word].self, from: jsonData)
        }
        catch {
            wordList = []
        }
        return wordList
    }
    
    
}

// MARK: - Language List Link
class LanguageListLinkCoder: LanguageLinkListProtocol {
    static func toJson(_ languageList: LanguageLinkList) -> String {
        do {
            return String(data: try JSONEncoder().encode<LanguageListLink>(languageList), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(langListJson: String) -> LanguageLinkList {
        var langLinkList: LanguageLinkList
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = langListJson.data(using: .utf8)!
            langLinkList = try jsonDecoder.decode(LanguageLinkList.self, from: jsonData)
        }
        catch {
            langLinkList = LanguageLinkList(linkId: UUID().uuidString)
        }
        return langLinkList
    }
    
    
}

// MARK: - Language Link
class LanguageLinkCoder: LanguageLinkProtocol {
    static func toJson(_ langLink: LanguageLink) -> String {
        do {
            return String(data: try JSONEncoder().encode<LanguageLink>(langLink), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(langListJson: String) -> LanguageLink {
        var langLink: LanguageLink
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = langListJson.data(using: .utf8)!
            langLink = try jsonDecoder.decode(LanguageLink.self, from: jsonData)
        }
        catch {
            langLink = LanguageLink()
        }
        return langLink
    }
    
    
}

// MARK: - Word Learner
class WordLearnerJsonCoder : WordLearnerJsonProtocol {
    static func toJson(_ learner: WordLearner?) -> String {
        do {
            return String(data: try JSONEncoder().encode<WordLearner?>(learner), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(learnerJson: String) -> WordLearner? {
        var learner: WordLearner?
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = learnerJson.data(using: .utf8)!
            learner = try jsonDecoder.decode(WordLearner.self, from: jsonData)
        }
        catch {
            learner = nil
        }
        return learner
    }
    
}

// MARK: - Settings
class SettingsJsonCoder: SettingsJsonProtocol {
    static func toJson(_ settings: LocalizationSettings) -> String {
        do {
            return String(data: try JSONEncoder().encode<Settings>(settings), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(settingJson: String) -> LocalizationSettings {
        var learner: LocalizationSettings
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = settingJson.data(using: .utf8)!
            learner = try jsonDecoder.decode(LocalizationSettings.self, from: jsonData)
        }
        catch {
            learner = LocalizationSettings(defaultFromLang: Languages.English, defaultToLang: Languages.Ukrainian, uiLanguage: Languages.English)
        }
        return learner
    }
}

// MARK: - Word Category List

class CategoryWordJsonCoder: CategoryWordJsonProtocol {
    
    
    static func toJson(_ category: CategoryWords) -> String {
        do {
            return String(data: try JSONEncoder().encode<WordCategory>(category), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(wordCategoryJson: String) -> CategoryWords {
        var category = CategoryWords.instanceEmptySaved()
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = wordCategoryJson.data(using: .utf8)!
            category = try jsonDecoder.decode(CategoryWords.self, from: jsonData)
        }
        catch {
            category = CategoryWords.instanceEmptySaved()
        }
        return category
    }
}


// MARK: - Autofill per day coder
class AutofillPerDayJsonCoder: AutofillPerDayJsonProtocol {
    static func toJson(_ apd: AutofillPerDay) -> String {
        do {
            return String(data: try JSONEncoder().encode<AutofillPerDay>(apd), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(apdJson: String) -> AutofillPerDay? {
        var apd = AutofillPerDay(count: 0, created: .now)
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = apdJson.data(using: .utf8)!
            apd = try jsonDecoder.decode(AutofillPerDay.self, from: jsonData)
        }
        catch {
            
        }
        return apd
    }
}

// MARK: - DayStreakJsonCoder
class DayStreakJsonCoder: DayStreakJsonProtocol {
    static func toJson(_ apd: DayStreak) -> String {
        do {
            return String(data: try JSONEncoder().encode<DayStreak>(apd), encoding: String.Encoding.utf8)!
        } catch {
            return ""
        }
    }
    
    static func fromJson(apdJson: String) -> DayStreak? {
        var apd = DayStreak(count: 1, created: .now)
        do {
            let jsonDecoder = JSONDecoder()
            let jsonData = apdJson.data(using: .utf8)!
            apd = try jsonDecoder.decode(DayStreak.self, from: jsonData)
        }
        catch {
            
        }
        return apd
    }
}



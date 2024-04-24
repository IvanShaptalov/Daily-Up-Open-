//
//  Languages.swift
//  Learn Up
//
//  Created by PowerMac on 25.12.2023.
//

import Foundation
/// 12 languages for now
enum Languages: String{
    case
    Spanish = "spanish",
    French = "french",
    Chinese = "chinese",
    German = "german",
    Portuguese = "portuguese",
    Russian = "russian",
    Arabic = "arabic",
    English = "english",
    Japanese = "japanese",
    Hindi = "hindi",
    Ukrainian = "ukrainian",
    Georgian = "georgian"
    // 12 languages
    static let emojiList = ["🇪🇸","🇫🇷","🇨🇳","🇩🇪","🇵🇹","🇷🇺","🇦🇪","🇬🇧","🇯🇵","🇮🇳","🇺🇦","🇬🇪"]
    
    static let allValues = [Spanish, French, Chinese, German, Portuguese, Russian, Arabic, English, Japanese, Hindi, Ukrainian, Georgian]
    
    static func removeEmoji(lang: String?) -> String {
        if lang == nil {
            return LearnUpConfiguration.defaultUILang.rawValue
        }
        var removedEmoji = ""
        removedEmoji = lang!.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        
        for emo in emojiList{
            if removedEmoji.contains(emo) {
                removedEmoji = removedEmoji.replacingOccurrences(of: emo, with: "")
                break
            }
        }
        return removedEmoji.lowercased()
    }
    
    
    static func langToEmoji(lang: Languages) -> String {
        switch lang {
        case .Spanish:
            return "🇪🇸"
        case .French:
            return "🇫🇷"
        case .Chinese:
            return "🇨🇳"
        case .German:
            return "🇩🇪"
        case .Portuguese:
            return "🇵🇹"
        case .Russian:
            return "🇷🇺"
        case .Arabic:
            return "🇦🇪"
        case .English:
            return "🇬🇧"
        case .Japanese:
            return "🇯🇵"
        case .Hindi:
            return "🇮🇳"
        case .Ukrainian:
            return "🇺🇦"
        case .Georgian:
            return "🇬🇪"
        }
    }
    
    func bcp47() -> String{
        switch self {
        case .Spanish:
            return "es-ES"
        case .French:
            return "fr-FR"
        case .Chinese:
            return "zh-CN"
        case .German:
            return "de-DE"
        case .Portuguese:
            return "pt-PT"
        case .Russian:
            return "ru-RU"
        case .Arabic:
            return "ar-AE"
        case .English:
            return "en-US"
        case .Japanese:
            return "ja-JP"
        case .Hindi:
            return "hi-IN"
        case .Ukrainian:
            return "uk-UA"
        case .Georgian:
            return "ka-GE"
        }
    }
    
    static func addFlag(word: String, lang: Languages) -> String {
        if [LearnUpConfiguration.addWords,LearnUpConfiguration.nothingToLearn].contains(word) {
            return "\(word)"
        }
        return "\(langToEmoji(lang: lang)) \(word)"
    }
}

extension Languages: Codable {
    
}

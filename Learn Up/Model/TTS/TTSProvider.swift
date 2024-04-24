//
//  TTSProvider.swift
//  Learn Up
//
//  Created by PowerMac on 10.02.2024.
//

import Foundation
import AVFAudio


class TTSProvider {
    static let synth = AVSpeechSynthesizer()
    
    static func voiceOver(_ rawText: String?, lang: Languages? = nil){
        var text = rawText
        
        // check text to nil
        guard text != nil else{
            return
        }
        // check local lang from parameters, if nul - try create
        var localLang = lang?.bcp47()
        if localLang == nil {
            localLang = NSLinguisticTagger.dominantLanguage(for: text!)
        }
        
        // if still nil - stop executing
        if localLang == nil {
            return
        }
        
        if lang == .Georgian {
            NSLog("Georgian language: \(text ?? "nil") ->")
            localLang = Languages.Ukrainian.bcp47()
            text = GeorgianTextConverter.convertText(text!)
            NSLog("Converted Georgian language: \(text ?? "nil")")
            
        }
        
        text = RemoverTextInBrackets.remove(text!)
        
        NSLog("start voice: \(text ?? "nil") - \(localLang ?? "nil")")
        //we now know the language of the text
        let utterance = AVSpeechUtterance(string: text!)
        utterance.voice = AVSpeechSynthesisVoice(language: localLang) //use the detected language
        
        synth.speak(utterance)
    }
}
class RemoverTextInBrackets{
    static func remove(_ text: String) -> String {
        var result = ""
        var insideBrackets = false

        for char in text {
            if char == "(" {
                insideBrackets = true
            } else if char == ")" {
                insideBrackets = false
            } else if !insideBrackets {
                result.append(char)
            }
        }

        return result
    }
}

class GeorgianTextConverter{
    static let transliterationToGeorgian: [Character: String] = [
        "ა": "а",
        "ბ": "б",
        "ვ": "в",
        "გ": "г",
        "დ": "д",
        "ე": "е",
        "ჟ": "ж",
        "ზ": "з",
        "ი": "і",
        "კ": "к",
        "ლ": "л",
        "მ": "м",
        "ნ": "н",
        "ო": "о",
        "პ": "п",
        "რ": "р",
        "ს": "с",
        "ტ": "т",
        "უ": "у",
        "ფ": "ф",
        "ხ": "х",
        "ც": "ц",
        "ჩ": "ч",
        "შ": "ш",
        "ჯ": "дж",
        "თ": "т",
        "ჭ": "тш",
        "ძ": "дз",
        "ღ": "ґ",
        "ყ": "кью",
        "ქ": "кх",
    ]
    
    static func convertText(_ georgianWord: String) -> String{
        var russianTransliteration = ""
        for char in georgianWord {
            if let transliteration = transliterationToGeorgian[char] {
                russianTransliteration += transliteration
            } else {
                russianTransliteration += String(char)
            }
        }
        return russianTransliteration
    }
    
    static private func convertChar(_ char: Character) -> String{
        return char.lowercased()
    }
}

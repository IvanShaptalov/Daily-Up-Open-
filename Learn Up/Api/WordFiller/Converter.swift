//
//  WordFiller.swift
//  Learn Up
//
//  Created by PowerMac on 08.01.2024.
//

import Foundation

protocol GPTConverterProtocol {
    static func delegateToRawApi(wfRequest: WordFillerRequestProtocol,converterCompletion: @escaping(WordFillerResponseProtocol)->())
}


class GPTConverter: GPTConverterProtocol {
    static func delegateToRawApi(wfRequest: WordFillerRequestProtocol, converterCompletion: @escaping (WordFillerResponseProtocol) -> ()) {
        NSLog("enter delegateToRawApi")
        
        

        let rawRequest = "translate '\(wfRequest.word)' from '\(wfRequest.fromLang)' to '\(wfRequest.toLang)'. give answer in this format: translation: _ | meaning: _ '"
        
        OpenAIApi.request(RawRequest(raw: rawRequest), rawCompletion: {response in
            NSLog("RAW completion")

            let fillerResponse: WordFillerResponseProtocol = fromRawToFiller(rawResponse: response.response)
            
            return converterCompletion(fillerResponse)
            
        })
    }
    
    public static func fromRawToFiller(rawResponse: String) -> WordFillerResponseProtocol {
        print("raw response: \(rawResponse)")
        let splitter = "|"
        
        let wordKey = ":"
        let wordKeyCh: Character = ":"
        let splitted = rawResponse.components(separatedBy: splitter)
        
        var translation = ""
        var meaning = LearnUpConfiguration.autofillPlaceholder
        let pronunciation = ""
        
        print("splitted count: \(splitted.count)")
        
        if splitted.count >= 2
        {
            for splittedPart in splitted {
                if splittedPart.contains(wordKey) && splittedPart.contains("translation"){
                    translation = String(splittedPart[splittedPart.lastIndex(of: wordKeyCh)!...]).replacingOccurrences(of: wordKey, with: "")
                }
                
                if splittedPart.contains(wordKey) && splittedPart.contains("meaning"){
                    meaning = String(splittedPart[splittedPart.lastIndex(of: wordKeyCh)!...]).replacingOccurrences(of: wordKey, with: "")
                }
            }
            
        }
        NSLog("\(pronunciation)| \(translation)| \(meaning)")
        return WordFillerResponse(pronunciation: pronunciation, translation: translation, meaning: meaning)
    }
    
    
    
}

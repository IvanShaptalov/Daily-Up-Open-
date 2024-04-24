//
//  WordFiller.swift
//  Learn Up
//
//  Created by PowerMac on 08.01.2024.
//

import Foundation

/// use Converter as layer
/// WordFiller fillWord -> Converter
/// Converter -> RawAPI
/// RawAPI -> Converter
/// Converter -> WordFiller fillWord Response
protocol WordFillerProtocol {
    static func fillWord(_ request: WordFillerRequestProtocol, fillerCompletion: @escaping(WordFillerResponseProtocol)->())
}

protocol WordFillerRequestProtocol {
    var word: String {get set}
    var toLang: Languages {get set}
    var fromLang: Languages {get set}
}

protocol WordFillerResponseProtocol {
    var pronunciation: String {get set}
    var translation: String {get set}
    var meaning: String {get set}
}


class WordFiller: WordFillerProtocol{
    static func fillWord(_ request: WordFillerRequestProtocol, fillerCompletion: @escaping (WordFillerResponseProtocol) -> ()) {
        NSLog("enter fillWord")
        GPTConverter.delegateToRawApi(wfRequest: request, converterCompletion: {response in
            
            NSLog("enter converter Completion \(response.translation)")

            return fillerCompletion(response)
        })
    }
}

class WordFillerRequest: WordFillerRequestProtocol, Equatable{
    static func == (lhs: WordFillerRequest, rhs: WordFillerRequest) -> Bool {
        return lhs.fromLang == rhs.fromLang &&
        lhs.toLang == rhs.toLang &&
        lhs.word == rhs.word
    }
    
    var word: String
    
    var toLang: Languages
    
    var fromLang: Languages
    
    init(word: String, toLang: Languages, fromLang: Languages) {
        self.word = word
        self.toLang = toLang
        self.fromLang = fromLang
    }
    
    
}

class WordFillerResponse: WordFillerResponseProtocol {
    var pronunciation: String
    
    var translation: String
    
    var meaning: String
    
    init(pronunciation: String, translation: String, meaning: String) {
        self.pronunciation = pronunciation
        self.translation = translation
        self.meaning = meaning
    }
    
    init(){
        self.pronunciation = "default"
        self.translation = "default"
        self.meaning = "default"
    }
}

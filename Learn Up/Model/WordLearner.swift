//
//  WordLearner.swift
//  Learn Up
//
//  Created by PowerMac on 02.01.2024.
//

import Foundation

// MARK: Word learning
struct WordLearner: Codable {
    var wordId: String {
        get {
            return word.id
        }
    }
    var word: Word
}

class LearnerLoader {
    static func loadWord(jsonWord: String?) -> Word{
                
        var word: Word?
        
        if jsonWord != nil {
            word = WordLearnerJsonCoder.fromJson(learnerJson: jsonWord!
            )?.word
        }
        
        if word == nil {
            word = Word(id: UUID().uuidString, fromLang: LearnUpConfiguration.defaultFromLang, toLang: LearnUpConfiguration.defaultUILang, word: LearnUpConfiguration.nothingToLearn, translation: LearnUpConfiguration.addWords, meaning: LearnUpConfiguration.addWordsExpanded, pronunciation: LearnUpConfiguration.pronunciation, trDate: Date.now, isLearned: false)
        }
        
        print("word: \(word!) ")
        
        return word!
        
    }
}

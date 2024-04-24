//
//  WordSelector.swift
//  Learn Up
//
//  Created by PowerMac on 29.12.2023.
//

import Foundation

class WordSelector: WordSelectorProtocol {
    
    static private let inWordSettings = ""
    
    static private let instructions: [String] = [LearnUpConfiguration.nothingToLearn, LearnUpConfiguration.addWords, LearnUpConfiguration.pronunciation,inWordSettings]
    
    static private func setUpLearner(wordLearner: inout WordLearner?,targetWord: WordProtocol) {
        wordLearner = WordLearner(word: targetWord as! Word)
    }
    
    static private func wordInstructions(word: WordProtocol) -> [String]{
        
        
        return [Languages.addFlag(word: word.word, lang: word.fromLang).capitalized
                ,Languages.addFlag(word: word.translation, lang: word.toLang).capitalized,
                word.pronunciation, word.meaning]
    }
    
    static func setUpWord(words: [WordProtocol], wordLearner: inout WordLearner?) -> [String] {
        // if all words is learned
        let anyNotLearnedWord: WordProtocol? = words.first(where: {!$0.isLearned})
        
        if anyNotLearnedWord == nil {
            wordLearner = nil
            return instructions
            
        } else if wordLearner != nil && words.first(where: {$0.id == wordLearner?.wordId && !$0.isLearned}) != nil{
            let word = words.first(where: {$0.id == wordLearner?.wordId})!
            setUpLearner(wordLearner: &wordLearner, targetWord: word)
            
            return wordInstructions(word: word)
        } else {
            let word = anyNotLearnedWord!
            setUpLearner(wordLearner: &wordLearner, targetWord: word)
            return wordInstructions(word: word)
        }
        
    }
}

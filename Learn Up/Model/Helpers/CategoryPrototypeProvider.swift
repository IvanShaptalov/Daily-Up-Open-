//
//  CategoryPrototypeLoader.swift
//  Learn Up
//
//  Created by PowerMac on 18.01.2024.
//

import Foundation


class CategoryPrototypeProvider {
    
    static public func reservedCategoriesCount() -> Int{
        return reservedCategories.count
    }
    // MARK: - Prototype Fields
    static private var reservedCategories =
    [
        WordAssetDemoArabic.wordCategory,
        WordAssetDemoChinese.wordCategory,
        WordAssetDemoEnglish.wordCategory,
        WordAssetDemoFrench.wordCategory,
        WordAssetDemoSakartvelo.wordCategory,
        WordAssetDemoGerman.wordCategory,
        WordAssetDemoHindi.wordCategory,
        WordAssetDemoJapanese.wordCategory,
        WordAssetDemoPortuegese.wordCategory,
        WordAssetDemoRussian.wordCategory,
        WordAssetDemoSpanish.wordCategory,
        WordAssetDemoUkrainian.wordCategory
    ]
    
    static var categoriesSetUp: Bool = false
    
    static private var fetchedCategoriesMeta: [CategoryWords] = []
    
    static public func allCategories() -> [CategoryWords] {
        let allCategories = reservedCategories + fetchedCategoriesMeta
        return allCategories
    }
    // MARK: - SET UP
    /// set up categories to discover
    static func setUp(){
        saveReservedCategoryPrototypes()
        fetchCategoriesMeta()
        categoriesSetUp = true
    }
    
    /// fetch all categories link from server
    static func fetchCategoriesMeta(){
        
    }
    
    static private func saveReservedCategoryPrototypes(){
        for category in  reservedCategories{
            CategoryPrototypeStorage.saveCategoryPrototypeLink(categoryId: category.id, title: category.title, language: category.language, isPremium: category.isPremium, assetPath: category.assetPath)
        }
    }
    
    static private func findExternalCategoryId(endpoint: String, language: Languages) -> String{
        return ""
    }
    
    // MARK: - GENERATING CATEGORY FROM SERVER
    static func tryGenerateCategoryFromServer(categoryId: String, toLanguage: Languages, callback: @escaping (CategoryWords) -> (), catchError: @escaping (FirebaseErrors) -> Void) {
        
        // get first category from server by id
        FirebaseStorage.shared.fetchFirstCategoryById(id: categoryId, receiveFirstCategory: {firstCategory, secondCategoryId in
            // get second category from server by id
            FirebaseStorage.shared.fetchSecondCategoryById(id: secondCategoryId, receiveSecondCategory: {secondCategory in
                // generate category from first and second categories
                if firstCategory == nil || secondCategory == nil {
                    catchError(FirebaseErrors.CategoryNotFound)
                    return
                }
                let generatedCategory = uniteTwoCategories(fromCategory: firstCategory!, translationCategory: secondCategory!)
                
                callback(generatedCategory)
            })
            {error in
                catchError(error)
            }
        })
        {error in
            catchError(error)
        }
    }
    
    // MARK: - GENERATING CATEGORY
    /// generate category from prototype to current language, generation become from func uniteTwoCategories
    static func tryGenerateCategory(categoryId: String, toLanguage: Languages) throws -> CategoryWords{
        assert(categoriesSetUp == true, ".setUp() before using generator")
        NSLog("CategoryPrototypeLoader> Start generate category \(categoryId)")
        
        // try get selected category by id
        guard let fromCategoryProt = fetchCategory(categoryId: categoryId) else {
            throw CategoryError.CategoryNotFound
        }
        
        // try get translation category id
        guard let externalId = getExternalCategoryId(categoryProt: fromCategoryProt, toLanguage: toLanguage) else {
            throw CategoryError.ExternalCategoryIdNotFound
        }
        
        // try get translation category
        guard let toCategoryProt = fetchCategory(categoryId: externalId) else {
            throw CategoryError.ExternalCategoryNotFound
        }
        
        return uniteTwoCategories(fromCategory: fromCategoryProt, translationCategory: toCategoryProt)
    }
    
    
    /// unite two category words, real generation here
    static private func uniteTwoCategories(fromCategory: CategoryWords, translationCategory: CategoryWords)-> CategoryWords{
        var resultCategory = fromCategory
        resultCategory.wordList = []
        
        NSLog(fromCategory.language.rawValue)
        NSLog(translationCategory.language.rawValue)
        
        resultCategory.id = UUID().uuidString
        
        for fromCWord in fromCategory.wordList {
            // same word id
            let translationWordId  = fromCWord.id
            
            var translationWord : Word?
            
            
            /// external word found
            
            translationWord = getExternalWordById(categoryProt: translationCategory, wordId: translationWordId)
            
            if translationWord != nil {
                let word = Word(id: UUID().uuidString,
                                fromLang: fromCategory.language,
                                toLang: translationCategory.language,
                                word: fromCWord.word,
                                translation: translationWord!.word,
                                meaning: translationWord!.meaningOrigin ?? "",
                                pronunciation: translationWord!.pronunciationOrigin ?? "",
                                trDate: fromCWord.trDate,
                                isLearned: false)
                
                
                resultCategory.wordList.append(word)
            }
            
        }
        
        return resultCategory
    }
    /// get word from category by id
    static private func getExternalWordById(categoryProt: CategoryWords, wordId: String) -> Word? {
        return categoryProt.wordList.first(where: {$0.id == wordId})
    }
    
    /// fetching category from reserved or from server
    static private func fetchCategory(categoryId: String) -> CategoryWords?{
        // try fetch from reserved
        NSLog("fetchCategory> try fetch from reserved")
        let categoryPrototype: CategoryWords? = fetchPrototypeFromReserved(categoryId: categoryId)
        
        return categoryPrototype
    }
    
    /// get id from category corresponding to language
    static private func getExternalCategoryId(categoryProt: CategoryWords, toLanguage: Languages) -> String? {
        return categoryProt.wordList.first?.languageLinkList?.getLangLink(lang: toLanguage)?.toCategory
    }
    
    /// get prototype from reserved prototypes
    static private func fetchPrototypeFromReserved(categoryId: String) -> CategoryWords?{
        return reservedCategories.first(where: {$0.id == categoryId})
    }
}


enum CategoryError: Error {
    case ExternalCategoryNotFound
    case CategoryNotFound
    case ExternalCategoryIdNotFound
}

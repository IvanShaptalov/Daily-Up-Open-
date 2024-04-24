//
//  FirebaseStorage.swift
//  Learn Up
//
//  Created by PowerMac on 30.01.2024.
//

import Foundation
import FirebaseDatabaseInternal


class FirebaseStorage {
    // MARK: - Endpoints
    static let metaEndpoint = "/volumes/meta_volumes"
    static let wordsEndpoint = "/volumes/value_volumes"
    
    var ref: DatabaseReference!
    
    static let shared = FirebaseStorage()
    
    private init() {
        self.ref = Database.database().reference()
    }
    
    // MARK: - Fetch first category
    func fetchFirstCategoryById(id: String, receiveFirstCategory: @escaping (CategoryWords?, String) -> (Void), catchError: @escaping (FirebaseErrors) -> Void){
        ref.child(id).observeSingleEvent(of: .value, with: {snapshot in
            do{
                guard let category = try self.snapshotToCategory(snapshot: snapshot) else {
                    throw FirebaseErrors.CategoryNotFound
                }
                guard let secondCategoryId = self.snapshotToVolumeLink(snapshot: snapshot, targetLang: LearnUpConfiguration.defaultUILang) else {
                    throw FirebaseErrors.CategoryIdNotFound
                }
                
                receiveFirstCategory(category, secondCategoryId)
            } catch FirebaseErrors.CategoryNotFound{
                catchError(FirebaseErrors.CategoryNotFound)
            } catch FirebaseErrors.CategoryIdNotFound {
                catchError(FirebaseErrors.CategoryIdNotFound)
            } catch {
                catchError(FirebaseErrors.UnknownError)
            }
            
        } ) {error in
            catchError(FirebaseErrors.CategoryNotFound)
            NSLog("*************************")
            NSLog(error.localizedDescription)
        }
    }
    
    // MARK: - fetch second category
    func fetchSecondCategoryById(id: String, receiveSecondCategory: @escaping(CategoryWords?) -> Void, catchError: @escaping (FirebaseErrors) -> Void){
        
        ref.child(id).observeSingleEvent(of: .value, with: {snapshot in
            do {
                guard let category = try self.snapshotToCategory(snapshot: snapshot) else {
                    throw FirebaseErrors.CategoryNotFound
                }
                receiveSecondCategory(category)
            } catch FirebaseErrors.CategoryNotFound{
                catchError(FirebaseErrors.CategoryNotFound)
            } catch FirebaseErrors.CategoryIdNotFound {
                catchError(FirebaseErrors.CategoryIdNotFound)
            } 
            catch FirebaseErrors.WordListNotFound {
                catchError(FirebaseErrors.WordListNotFound)
            }
            catch {
                catchError(FirebaseErrors.UnknownError)
            }
        } ) {error in
            catchError(FirebaseErrors.CategoryNotFound)
            NSLog("*************************")
            NSLog(error.localizedDescription)
        }
    }
    
    // MARK: - snapshot to category
    func snapshotToCategory(snapshot: DataSnapshot) throws -> CategoryWords? {
        print(snapshot)
        // Get user value
        guard let value = snapshot.value as? NSDictionary else {
            return nil
        }
        
        guard let currentCategoryMeta = value[FirebaseMetaCategoryKeys.meta] as? NSDictionary else {
            NSLog("meta not exists")
            return nil
        }
        
        guard let title = currentCategoryMeta[FirebaseMetaCategoryKeys.title] as? String else {
            NSLog("title not exists")
            
            return nil
        }
        
        guard let rawLanguage = currentCategoryMeta[FirebaseMetaCategoryKeys.rawLanguage] as? String else {
            NSLog("rawLang not exists")
            
            return nil
        }
        
        guard let lang = Languages(rawValue: rawLanguage) else {
            NSLog("lang not convertable")
            
            return nil
        }
        
        let id = UUID().uuidString
        
        guard let isPremium = currentCategoryMeta[FirebaseMetaCategoryKeys.isPremium] as? Bool else {
            NSLog("isPremium field not exists")
            return nil
        }
        
        let assetPath = currentCategoryMeta[FirebaseMetaCategoryKeys.assetPath] as? String ?? LearnUpConfiguration.baseCategoryAssetPath
        
        var result = CategoryWords(title:  title,
                                   language: lang,
                                   id: id,
                                   isPremium: isPremium,
                                   assetPath: assetPath)
       
        try self.generateWordList(dict: value,category: &result)
       
        return result
    }
    
    // MARK: - generate words
    func generateWordList(dict: NSDictionary, category: inout CategoryWords) throws {
        guard let dictWordList: NSArray = dict[FirebaseMetaCategoryKeys.words] as? NSArray else {
            throw FirebaseErrors.WordListNotFound
        }
        
        for dictWordRaw in dictWordList {
            guard let dictWord = dictWordRaw as? NSDictionary else {
                throw FirebaseErrors.WordListGeneratingError
            }
            
            let word = Word(id: dictWord[FirebaseWordKeys.id] as! String, fromLang: category.language, toLang: category.language, word: dictWord[FirebaseWordKeys.wordOrigin] as! String, translation: dictWord[FirebaseWordKeys.wordOrigin] as! String, meaning: dictWord[FirebaseWordKeys.meaningOrigin] as! String, pronunciation: "", trDate: .now, isLearned: false, meaningOrigin: (dictWord[FirebaseWordKeys.meaningOrigin] as! String))
            category.wordList.append(word)
        }
        print(category)
    }
    
    // MARK: - get link to second category
    func snapshotToVolumeLink(snapshot: DataSnapshot, targetLang: Languages) -> String? {
        guard let value = snapshot.value as? NSDictionary else {
            return nil
        }
        
        guard let volumeLink = value[FirebaseMetaCategoryKeys.volumeLinks] as? NSDictionary else {
            NSLog("link not exists")
            return nil
        }
        
        guard let mapLink = volumeLink[FirebaseMetaCategoryKeys.mapLink] as? String else {
            NSLog("map_link not exists")
            return nil
        }
        
        return addLangToVolumeLink(mapLink: mapLink, targetLang: targetLang)
    }
    
    func addLangToVolumeLink(mapLink: String, targetLang: Languages) -> String{
        return mapLink + targetLang.rawValue
    }
    
    // MARK: - get all meta
    func fetchAllPrototypes(callback: @escaping (DataSnapshot) -> Void){
        ref.child(FirebaseStorage.metaEndpoint).observeSingleEvent(of: .value, with: callback) { error in
            print(error.localizedDescription)
        }
        
    }
    
    static func snapshotToCategories(snapshot: DataSnapshot) -> [[String: Any]] {
        print(snapshot)
        var result: [[String: Any]] = []
        // Get user value
        guard let value = snapshot.value as? NSDictionary else {
            return []
        }
        
        for vol in LearnUpConfiguration.firebaseVolList {
            guard let currentVol = value[vol] as? NSDictionary else {
                continue
            }
            for firebaseLang in Languages.allValues.map({$0.rawValue}) {
                guard let currentCategory = currentVol[firebaseLang] as? NSDictionary else {
                    continue
                }
                guard let currentCategoryMeta = currentCategory[FirebaseMetaCategoryKeys.meta] as? NSDictionary else {
                    continue
                }
                
                result.append([
                    LocalMetaCategoryKeys.assetPath:
                        currentCategoryMeta[FirebaseMetaCategoryKeys.assetPath] as? String ?? LearnUpConfiguration.baseCategoryAssetPath,
                    LocalMetaCategoryKeys.title:
                        currentCategoryMeta[FirebaseMetaCategoryKeys.title] as? String ?? "vol2",
                    LocalMetaCategoryKeys.isPremium:
                        currentCategoryMeta[FirebaseMetaCategoryKeys.isPremium] as? Bool ?? false,
                    LocalMetaCategoryKeys.rawLanguage:
                        currentCategoryMeta[FirebaseMetaCategoryKeys.rawLanguage] as? String ?? "english",
                    LocalMetaCategoryKeys.id: currentCategoryMeta[FirebaseMetaCategoryKeys.id]!,
                    LocalMetaCategoryKeys.isFromFirebase: true
                ])
                
            }
        }
        
        return result
    }
}

// MARK: - Errors
enum FirebaseErrors: Error {
    case
    CategoryNotFound,
    CategoryIdNotFound,
    UnknownError,
    WordListNotFound,
    WordListGeneratingError
}

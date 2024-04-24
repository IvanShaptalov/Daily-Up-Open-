import Foundation

// MARK: - Words Storage
class Storage: StorageProtocol {
    static func saveJson(json: String, key: String) {
        StorageConfiguration.storage!.set(json, forKey: key)
    }
    
    static func loadJson(key: String) -> String? {
        return StorageConfiguration.storage!.string(forKey: key)
    }
}


// MARK: - Selected Category Storage
class SelectedCategoryStorage {
    static func loadLink() -> String? {
        return StorageConfiguration.storage!.string(forKey: StorageConfiguration.selectedCategory)
    }
    
    static func saveLink(categoryId: String){
        StorageConfiguration.storage!.set(categoryId, forKey: StorageConfiguration.selectedCategory)
    }
}



class SettingsStorage: LangStorageProtocol {
    //MARK: - Languages
    
    static func saveLang(lang: Languages, key: String) {
        StorageConfiguration.storage!.set(lang.rawValue, forKey: key)
    }
    
    static func loadLang(key: String) -> Languages? {
        let rawLang = StorageConfiguration.storage!.string(forKey: key)
        
        if (rawLang != nil) {
            return Languages(rawValue: rawLang!)
        }
        return nil
        
    }
    
    //MARK: - First launch
    
    
    static func saveIsFirstLaunch(_ isFLaunch: Bool) {
        StorageConfiguration.storage!.set(isFLaunch, forKey: StorageConfiguration.launchedBefore)
    }
    
    static func loadIsFirstLaunch() -> Bool {
        let isFirstLaunch = StorageConfiguration.storage!.bool(forKey: StorageConfiguration.launchedBefore)
        
        return isFirstLaunch
    }
    
    //MARK: - Rate
    
    
    static func saveRatedBefore(isRatedBefore: Bool) {
        StorageConfiguration.storage!.set(isRatedBefore, forKey: StorageConfiguration.ratedBefore)
        
    }
    
    static func loadRatedBefore() -> Bool {
        let ratedBefore = StorageConfiguration.storage!.bool(forKey: StorageConfiguration.ratedBefore)
        return ratedBefore
    }
    
    //MARK: - App version
    
    static func saveAppVersion(appVersion: String) {
        StorageConfiguration.storage!.set(appVersion, forKey: StorageConfiguration.appVersion)
    }
    
    static func loadAppVersion() -> String?{
        let appVersion: String? = StorageConfiguration.storage!.string(forKey: StorageConfiguration.appVersion)
        return appVersion
    }
}


enum Operation {
    case
    edit,
    delete
}

// MARK: - Word Category Storage
class CategoryWordStorage{
    static func loadJson(key: String) -> String? {
        return StorageConfiguration.storage!.string(forKey: key)
    }
    
    static func saveJson(category: CategoryWords) {
        // save category by id
        NSLog("category saved: \(category.id)")
        StorageConfiguration.storage!.set(CategoryWordJsonCoder.toJson(category)
                                          , forKey: category.id)
        // then save meta category without words in storage
        updateLink(categoryId: category.id, title: category.title, language: category.language, isPremium: category.isPremium, assetPath: category.assetPath, operation: .edit)
    }
    
    static func removeCollection(category: CategoryWords) {
        // save category by id
        NSLog("category saved: \(category.id)")
        StorageConfiguration.storage!.removeObject(forKey: category.id)
        // then save meta category without words in storage
        updateLink(categoryId: category.id, title: category.title, language: category.language, isPremium: category.isPremium, assetPath: category.assetPath, operation: .delete)
    }
    
    /// save word meta in storage category link map
    private static func updateLink(categoryId: String, title: String, language: Languages, isPremium: Bool, assetPath: String, operation: Operation) {
        // load all links
        var linkArray = loadAllCategoryLinks()
        
        if operation == .delete {
            NSLog("remove collection")
            linkArray.removeAll(where: {$0["id"] as? String == categoryId})
        } else {
            // create link
            let link: [String: Any] = ["id": categoryId, "title": title, "language": language.rawValue, "isPremium": isPremium, "created": Date.now, "assetPath": assetPath]
            
            // find in links
            var loadedLink = linkArray.first(where: {$0["id"] as? String == categoryId})
            if loadedLink == nil {
                linkArray.append(link)
            }
            // update link in link array
            else if type(of: loadedLink) == [String: Any].self{
                loadedLink!.updateValue(link, forKey: categoryId)
                let index = linkArray.firstIndex(where: {$0["id"] as? String == categoryId})
                if index != nil{
                    NSLog("Storage > updateLink> updated link: \(loadedLink!)")
                    linkArray[index!] = loadedLink!
                }
            }
        }
        StorageConfiguration.storage!.set(linkArray, forKey: StorageConfiguration.wordCategoryLinkListKey)
    }
    
    /// this storage contains all generated and ready to use categories
    static func loadAllCategoryLinks() -> [[String: Any]] {
        // right
        let links: [[String:Any]] = (StorageConfiguration.storage!.array(forKey: StorageConfiguration.wordCategoryLinkListKey) as? [[String:Any]]) ?? []
        return links
    }
    
    static func clearAllCategoryLinks() {
        StorageConfiguration.storage!.set([], forKey: StorageConfiguration.wordCategoryLinkListKey)
    }
}

// MARK: - Categpry Prototype

class CategoryPrototypeStorage {
    /// this storage contains all category prototypes that can generate categories
    static func loadCategoryPrototypes() -> [[String: Any]] {
        // right
        let links: [[String:Any]] = (StorageConfiguration.storage!.array(forKey: StorageConfiguration.categoryPrototypeLinkListKey) as? [[String:Any]]) ?? []
        return links
    }
    
    static func saveCategoryPrototypeLink(categoryId: String, title: String, language: Languages, isPremium: Bool, assetPath: String) {
        // load all links
        var linkArray = loadAllCategoryPrototypeLinks()
        
        // create link
        let link: [String: Any] = ["id": categoryId, "title": title, "language": language.rawValue, "isPremium": isPremium, "created": Date.now, "assetPath": assetPath]
        
        // find in links
        var loadedLink = linkArray.first(where: {$0["id"] as? String == categoryId})
        if loadedLink == nil {
            linkArray.append(link)
        }
        // update link in link array
        else if type(of: loadedLink) == [String: Any].self{
            loadedLink!.updateValue(link, forKey: categoryId)
            let index = linkArray.firstIndex(where: {$0["id"] as? String == categoryId})
            if index != nil{
                NSLog("Storage > updateLink> updated link: \(loadedLink!)")
                linkArray[index!] = loadedLink!
            }
        }
        StorageConfiguration.storage!.set(linkArray, forKey: StorageConfiguration.categoryPrototypeLinkListKey)
    }
    
    static private func loadAllCategoryPrototypeLinks() -> [[String: Any]] {
        // right
        let links: [[String:Any]] = (StorageConfiguration.storage!.array(forKey: StorageConfiguration.categoryPrototypeLinkListKey) as? [[String:Any]]) ?? []
        return links
    }
}

// MARK: - AutoFillStorage

class AutoFillPerDayStorage: AutofillPerDayStorageProtocol {
    static func save(apd: AutofillPerDay) {
        StorageConfiguration.storage!.set(AutofillPerDayJsonCoder.toJson(apd), forKey: StorageConfiguration.autofillCounterKey)
    }
    
    static func load() -> AutofillPerDay {
        guard let apdJson: String = StorageConfiguration.storage!.string(forKey: StorageConfiguration.autofillCounterKey) else {
            
            NSLog("AutofillPerDayStorage > new load > '0'")
            return .init(count: 0, created: .now)
        }
        
        guard let apd = AutofillPerDayJsonCoder.fromJson(apdJson: apdJson) else {
            return .init(count: 0, created: .now)
        }
        
        return apd
    }
    
    static func remove() {
        StorageConfiguration.storage!.removeObject(forKey: StorageConfiguration.autofillCounterKey)
    }
}


// MARK: - Day streak storage
class DayStreakStorage: DayStreakCounterStorageProtocol {
    static func save(apd: DayStreak) {
        StorageConfiguration.storage!.set(DayStreakJsonCoder.toJson(apd), forKey: StorageConfiguration.dayStreakKey)
    }
    
    static func load() -> DayStreak {
        guard let apdJson: String = StorageConfiguration.storage!.string(forKey: StorageConfiguration.dayStreakKey) else {
            let apd: DayStreak = .init(count: 1, created: .now)
            save(apd: apd)
            NSLog("AutofillPerDayStorage > json empty > '0'")
            return apd
        }
        
        guard let apd = DayStreakJsonCoder.fromJson(apdJson: apdJson) else {
            let apd: DayStreak = .init(count: 1, created: .now)
            save(apd: apd)
            NSLog("AutofillPerDayStorage > json invalid > '0'")
            return apd
        }
        
        return apd
    }
    
    static func remove() {
        StorageConfiguration.storage!.removeObject(forKey: StorageConfiguration.dayStreakKey)
    }
}

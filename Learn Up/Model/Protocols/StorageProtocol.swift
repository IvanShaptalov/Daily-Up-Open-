import Foundation

// MARK: - Storage
protocol StorageProtocol {
    static func loadJson(key: String) -> String?
    
    static func saveJson(json: String, key: String)
}

// MARK: - Lang Storage
protocol LangStorageProtocol {
    static func saveLang(lang: Languages, key: String)
    
    static func loadLang(key: String) -> Languages?
}



// MARK: - Autofilled Per Day Protocol

protocol AutofillPerDayStorageProtocol{
    static func save(apd: AutofillPerDay)
    
    static func load() -> AutofillPerDay
}


// MARK: - DayStreak counter protocol


protocol DayStreakCounterStorageProtocol{
    static func save(apd: DayStreak)
    
    static func load() -> DayStreak
}

//
//  CategorySelector.swift
//  Learn Up
//
//  Created by PowerMac on 16.01.2024.
//

import Foundation

class CategorySelector: CategorySelectorProtocol {
    static func setUpWordCategory() -> CategoryWords {
        
        // try to fetch from server
        let selectedId = SelectedCategoryStorage.loadLink()
        print("selected id: \(selectedId ?? "nil")")
        var selectedCategory:  CategoryWords?
        
        if selectedId == nil {
            tryFetchCategoryFromServer()
        }
       
        // try fetch from storage
        else if selectedId != nil {
            let jsonCategory: String? = CategoryWordStorage.loadJson(key: selectedId!)
            
            if jsonCategory != nil {
                selectedCategory = CategoryWordJsonCoder.fromJson(wordCategoryJson: jsonCategory!)
            }
            
        }
        
        // try fetch saved
        if selectedCategory == nil {
            let jsonCategory: String? = CategoryWordStorage.loadJson(key: StorageConfiguration.savedCategoryKey)
            
            if jsonCategory != nil {
                selectedCategory = CategoryWordJsonCoder.fromJson(wordCategoryJson: jsonCategory!)
            }
        }
        
        // use placeholder
        if selectedCategory == nil {
            selectedCategory = .instanceEmptySaved()
        }
    
        return selectedCategory!
    }
    
    static func tryFetchCategoryFromServer() {
        
    }
}

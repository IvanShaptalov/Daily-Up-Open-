//
//  CategoryGeneratorSelector.swift
//  Learn UpTests
//
//  Created by PowerMac on 18.01.2024.
//

import Foundation
import XCTest

extension Learn_UpTests {
    // MARK: - Category prototype generator
    func testReservedCategory() throws {
        XCTAssertEqual(CategoryPrototypeProvider.reservedCategoriesCount(), 12)
    }
    
    func testAllCategories() throws {
        XCTAssertGreaterThanOrEqual(CategoryPrototypeProvider.allCategories().count, 12)
    }
    
    func testGenerateCategoryNormal() throws {
        CategoryPrototypeProvider.setUp()
        var category: CategoryWords?
        do {
           category = try CategoryPrototypeProvider.tryGenerateCategory(categoryId: "russianDemo", toLanguage: .English)
        }
        catch {
            
        }
        
        XCTAssertNotNil(category)
        XCTAssert(!category!.wordList.isEmpty)
       
        let word = category!.wordList.first!
        
        XCTAssertEqual(word.fromLang, .Russian)
        XCTAssertEqual(word.toLang, .English)
    }
    
    func testGenerateCategoryNotFound() throws {
        CategoryPrototypeProvider.setUp()
        do {
            _ = try CategoryPrototypeProvider.tryGenerateCategory(categoryId: "", toLanguage: .English)
        }
        catch CategoryError.CategoryNotFound{
            XCTAssertTrue(true)
            return
        }
        XCTFail()
        
    }
}

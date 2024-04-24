//
//  FirebaseTest.swift
//  Learn UpTests
//
//  Created by PowerMac on 30.01.2024.
//

import Foundation
import XCTest
@testable import Learn_Up



extension Learn_UpTests {
    func testLoadAllPrototypes() throws {
        
        FirebaseStorage.shared.fetchAllPrototypes(callback: { snapshot in
            let categories = FirebaseStorage.snapshotToCategories(snapshot: snapshot)
            print(categories)
            XCTAssertEqual(categories.count, 12)
        })
        
        sleep(10)

    }
}

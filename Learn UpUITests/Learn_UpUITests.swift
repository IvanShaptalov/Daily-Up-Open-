//
//  Learn_UpUITests.swift
//  Learn UpUITests
//
//  Created by PowerMac on 23.12.2023.
//

import XCTest

final class Learn_UpUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    func testNavigation() {
//      // 1
//      let burjKhalifaPredicate = NSPredicate(format: "label beginswith 'Burj Khalifa'")
//
//      // 2
//      app.tables.buttons.element(matching: burjKhalifaPredicate).tap()
//
//      // 3
//      app.navigationBars.buttons["Tallest Towers"].tap()
//
//      // 4
//      let shanghaiTowerPredicate = NSPredicate(format: "label beginswith 'China'")
//      app.tables.buttons.element(matching: shanghaiTowerPredicate).tap()
//      app.navigationBars.buttons["Tallest Towers"].tap()
//    }
//    
//    func testTowerDetailView() {
//      // 1
//      let chinaZunPredicate = NSPredicate(format: "label beginswith 'China Zun'")
//      app.tables.buttons.element(matching: chinaZunPredicate).tap()
//
//      // 2
//      XCTAssert(app.staticTexts["China Zun"].exists)
//      XCTAssert(app.staticTexts["Beijing, China"].exists)
//      XCTAssert(app.staticTexts["528m"].exists)
//      XCTAssert(app.staticTexts["Constructed in"].exists)
//      XCTAssert(app.staticTexts["2018"].exists)
//    }
//    
//    func testTowerDetailView() {
//      let app = XCUIApplication()
//      let tablesQuery = app.tables
//      tablesQuery.cells["Burj Khalifa, Dubai, United Arab Emirates, 828m"].children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
//
//      XCTAssert(app.staticTexts["Burj Khalifa"].exists)
//      XCTAssert(app.staticTexts["Dubai, United Arab Emirates"].exists)
//      XCTAssert(app.staticTexts["828m"].exists)
//      XCTAssert(app.staticTexts["Constructed in"].exists)
//      XCTAssert(app.staticTexts["2010"].exists)
//    }
//    
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

//
//  StackReviewUITests.swift
//  StackReviewUITests
//
//  Created by Andres Kwan on 8/18/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import XCTest

class StackReviewUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        XCUIDevice.sharedDevice().orientation = .Portrait
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAboutButton() {
        let mainLandingTitleLabel = app.navigationBars.staticTexts["StackReview"]
        XCTAssertTrue(mainLandingTitleLabel.exists, "Should be on the start screen")
//        app.buttons["About"].tap()
        app.navigationBars.buttons["About"].tap()
        
        let aboutViewTitleLabel = app.navigationBars.staticTexts["About"]
        XCTAssertTrue(aboutViewTitleLabel.exists, "Should be on the about screen")
        
    }
    
    /*
     Testing the maser-detail segue
     - tap on a row, and then go to the dail screen
     */
    func testMasterDetailSegueFromTableRowToDetailView() {
        let mainLandingTitleLabel = app.navigationBars.staticTexts["StackReview"]
        XCTAssertTrue(mainLandingTitleLabel.exists, "Should be on the start screen")
        
        let table = app.tables
//        table.staticTexts["Stack 'em High"].tap()
        let cellStackThemHigh = table.cells.staticTexts["Stack 'em High"]
        //this tap() takes me to the detail, that's why I can assert the value of cell after
        //taped because it's gone!
        cellStackThemHigh.tap()
        XCTAssertEqual(cellStackThemHigh.exists, false, "Should not exits, now we are in the detail view")
        //don't work
        //        table.buttons["Stack 'em High"].tap()
        let detailButtonTitle = app.buttons["Hide Details"]
        XCTAssertTrue(detailButtonTitle.exists, "Should be on detail view")
    }
    
    func testHideMapDetailView() {

        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .Portrait
        XCUIDevice.sharedDevice().orientation = .LandscapeLeft
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        //swipeRight is not correct because we are in landscape mode.
        tablesQuery.staticTexts["Stack 'em High"].swipeRight()
        tablesQuery.staticTexts["Ye Olde Pancake"].tap()
        app.buttons["Hide Map"].tap()
        
        
    }
}

//
//  StackReviewTests.swift
//  StackReviewTests
//
//  Created by Andres Kwan on 8/17/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import XCTest
@testable import StackReview

class StackReviewTests: XCTestCase {
    
    let pancakeCollection = PancakeHouseCollection()
    
    //1 create a pancake
    let pancake = PancakeHouse(dict:[
        "name": "Test Pancake House",
        "priceGuide": 0, //PriceGuide.High,
        "details": "Test detail",
        "rating": 1000   //PancakeRating()
        ])
    
    override func setUp() {
        super.setUp()
        pancakeCollection.loadTestData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCollectionHasPancakes() {
        XCTAssertGreaterThan(pancakeCollection.count, 0, "pancake collection didn't have at least one pancake!")
    }
    
    func testAddPancakeToTheCollection() {
        //2 save the number of pancakes in the collection
        let startCount = pancakeCollection.count
        
        //3 add the pancake to the collection
        pancakeCollection.addPancakeHouse(pancake!)
        
        //4 compare the quantity of pancakes before and after
        XCTAssertEqual(pancakeCollection.count, startCount + 1, "addPancakeHouse() is not adding a pancake to the collection")
    }
    
    /*
     two things to test 
     1 remove pancake if it is not the favorite
     2 do not remove the pancake if it is the favorite
     */
    func testRemoveNonFavoritePancakeFromCollection() {
        //1 save the number of pancakes in the collection
        let startCount = pancakeCollection.count
        
        //2 take a pancake from the collection
        let pancakeToRemove = pancakeCollection[0]
        
        //3 remove the pancake 
        pancakeCollection.removePancakeHouse(pancakeToRemove)
        
        //4 compare the quantity of pancakes before and after
        XCTAssertEqual(pancakeCollection.count, startCount - 1, "removePancakeHouse() is not removing a pancake from the collection")
        
    }
    /*
     
     */
    func testCloudLoadFails() {
        //Async call 
        // 1 add expectations
        let expectation = expectationWithDescription("Expecting clud data call to fail")
        // 2 add async call
        pancakeCollection.loadCloudTestData { (didReceiveData) -> () in
            if didReceiveData {
                //not what we want 
                //so always fails
                XCTFail()
            } else {
                // the thing that we expected, actually happened
                expectation.fulfill()
            }
        }
        // at this point the method concludes, that is why we need to wait 
        // 3sec
        // in the "handler" I could review what is coming
        // so we can add more assertions
        waitForExpectationsWithTimeout(3, handler: nil)
    }
    
    /*
     To testCloudLoadSuccess()
     we need a mock, why? because we don't have access to the cloud, we need a logged in user
     */
    func testCloudLoadSuccess() {
        // reasonably good solution for when some clever overriding can do enough to simulate certain conditions and behaviors.
        class MockPancakeHouseCollection: PancakeHouseCollection {
            override var isCloudCollection: Bool {
                //now it seems that there is a logged in user
                return true
            }
        }
        // create an instance of the mock
        let mockCollection = MockPancakeHouseCollection()
        //Async call
        // 1 add expectations
        let expectation = expectationWithDescription("Expecting clud data call to fail")
        // 2 add async call
        mockCollection.loadCloudTestData { (didReceiveData) -> () in
            if didReceiveData {
                // the thing that we expected, actually happened
                expectation.fulfill()
            } else {
                //not what we want
                //so always fails
                XCTFail()
            }
        }
        waitForExpectationsWithTimeout(3, handler: nil)
        
    }
}

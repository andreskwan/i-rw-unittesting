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
        "name": "Test Pancake House" as AnyObject,
        "priceGuide": 0 as AnyObject, //PriceGuide.High,
        "details": "Test detail" as AnyObject,
        "rating": 1000 as AnyObject   //PancakeRating()
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
     The favorite pancake in the collection can be removed
     so the collection should be the same
     */
    func testRemoveFavoritePancakeFromCollection() {
        //1 save the number of pancakes in the collection
        let startCount = pancakeCollection.count
        
        //2 take a pancake from the collection
        let favoritePancake = pancakeCollection[0]
        
        //3 set the favorite pancake
        pancakeCollection.favorite = favoritePancake
        
        //4 assert favorite is set
        XCTAssertNotNil(pancakeCollection.favorite)
        
        //5 assert pancake is favorite
        XCTAssertTrue(pancakeCollection.isFavorite(favoritePancake))
        
        //6 remove favorite pancake
        pancakeCollection.removePancakeHouse(favoritePancake)
        
        //7 assert that the number of pancakes remains 
        XCTAssertEqual(startCount, pancakeCollection.count)
        
        //8 assert that pancake in the collection is the favorite
        XCTAssertEqual(pancakeCollection[0], favoritePancake)
    }
    
    /*
     Async Call
     load data from the cloud should fail because we are not logged in
     */
    func testCloudLoadFails() {
        //Async call 
        // 1 add expectations
        let expectation = self.expectation(description: "Expecting cloud data call to fail")
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
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    /*
     To testCloudLoadSuccess()
     we need a mock, why? because we don't have access to the cloud, we need 
     to fake a logged in user
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
        let expectation = self.expectation(description: "Expecting clud data call to fail")
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
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testCollectionDoesNotHaveAFavoritePancake() {
        //if favorite is nil, there is not a favorite pancake 
        //this test the getter
        XCTAssertNil(pancakeCollection.favorite)
    }
    
    func testCollectionHasAFavoritePancake() {
        //if favorite is nil, there is not a favorite pancake
        //this test the setter
        let favoritePancake = pancakeCollection[0]
        let noFavoritePancake = pancakeCollection[1]
        pancakeCollection.favorite = favoritePancake
        //asumes that I could compare two pancakes
//        XCTAssertTrue((pancakeCollection.favorite) == favoritePancake)
        XCTAssertTrue(pancakeCollection.isFavorite(favoritePancake))
        XCTAssertFalse(pancakeCollection.isFavorite(noFavoritePancake))
    }
    
    /*
     Only a pancake in the collection can be favorite
     */
    func testSetFavoriteNotInCollection() {
        let favoritePancake = pancakeCollection[0]
        pancakeCollection.removePancakeHouse(favoritePancake)
        pancakeCollection.favorite = favoritePancake
        XCTAssertNotNil(favoritePancake)
        XCTAssertNil(pancakeCollection.favorite)
        // validates if the favorite set is the
        if let favorite = pancakeCollection.favorite {
            XCTAssertTrue(pancakeCollection.isFavorite(favorite))
        }
    }
}

// MARK: Performance test
extension StackReviewTests {
    func testPerformanceLoadDataTime() {
        measure { 
            self.pancakeCollection.loadTestData()
        }
    }
}
    

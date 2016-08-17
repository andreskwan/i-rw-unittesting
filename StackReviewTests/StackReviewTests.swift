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
        //1 add the pancake to the collection
        pancakeCollection.addPancakeHouse(pancake!)
        
        //2 save the number of pancakes in the collection
        let startCount = pancakeCollection.count
     
        //3 remove the pancake 
        pancakeCollection.removePancakeHouse(pancake!)
        
        //4 compare the quantity of pancakes before and after
        XCTAssertEqual(pancakeCollection.count, startCount - 1, "removePancakeHouse() is not removing a pancake from the collection")
        
    }
}

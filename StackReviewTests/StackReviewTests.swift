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
        //1 create a pancake
        let pancake = PancakeHouse(dict:[
            "name": "Test Pancake House",
            "priceGuide": 0, //PriceGuide.High,
            "details": "Test detail",
            "rating": 1000   //PancakeRating()
            ])
        
        //2 save the number of pancakes in the collection
        let startCount = pancakeCollection.count
        
        //3 add the pancake to the collection
        pancakeCollection.addPancakeHouse(pancake!)
        
        //4 compare the quantity of pancakes before and after
        XCTAssertEqual(pancakeCollection.count, startCount + 1, "addPancakeHouse function is not adding pancakes to the collection")
        
    }
}

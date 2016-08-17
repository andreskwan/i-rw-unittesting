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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCollectionHasPancakes() {
        //this line is placed on the setUp() method, is needed
        pancakeCollection.loadTestData()
        XCTAssertGreaterThan(pancakeCollection.count, 0, "pancake collection didn't have at least one pancake!")
    }
    
    func textAddPancakeToTheCollection() {
        //0 load collection with test data 
        
        //1 create a pancake
        
        //2 save the number of pancakes in the collection
        
        //3 add the pancake to the collection
        
        //4 compare the quantity of pancakes before and after
        
    }
}

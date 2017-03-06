//
//  GYTagViewTests.swift
//  GYTagViewTests
//
//  Created by kokozu on 2017/3/6.
//  Copyright © 2017年 guoyi. All rights reserved.
//

import XCTest
@testable import GYTagView

class GYTagViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let frame = CGRect(x: 0, y: 200, width: 375, height: 300)
        let tags = ["罗卡就离开的肌肤", "罗卡就离", "罗卡就离开的肌是大丰收肤", "罗的肌肤", "罗卡就的肌肤", "罗卡就离开", "罗卡就离开大发的说法地方的肌肤", "罗卡就的肌肤", "罗卡就离开的肌肤"]
        let tagView = GYTagView(frame: frame, tags: tags)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}

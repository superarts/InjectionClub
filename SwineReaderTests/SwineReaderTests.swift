//
//  SwineReaderTests.swift
//  SwineReaderTests
//
//  Created by Leo Liu on 8/22/17.
//  Copyright © 2017 Swine Reader Community. All rights reserved.
//

import XCTest
@testable import SwineReader

class SwineReaderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
		DependencyContainer.setup()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testQueriedAvatarIsValid() {
		let queriedAvatar = DependencyContainer.container.resolve(Avatar.self)!
		queriedAvatar.show(uid: 42)
		XCTAssertEqual(queriedAvatar.isValid(), true)
    }
    
    func testPerformanceExample() {
        self.measure {
        }
    }
}
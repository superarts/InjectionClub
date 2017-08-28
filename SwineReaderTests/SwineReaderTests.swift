//
//  SwineReaderTests.swift
//  SwineReaderTests
//
//  Created by Leo Liu on 8/22/17.
//  Copyright © 2017 Swine Reader Community. All rights reserved.
//

import XCTest
@testable import SwineReader

class QueriedAvatarTests: XCTestCase {
	var queriedAvatar: Avatar!

    override func setUp() {
        super.setUp()
		queriedAvatar = DependencyContainer.setup().resolve(Avatar.self)!
		queriedAvatar.show(uid: 42)
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testQueriedAvatarIsValid() {
		XCTAssertTrue(queriedAvatar.isValid())
    }
    func testQueriedAuthorIsNotNil() {
		XCTAssertNotNil(queriedAvatar.author)
	}
    func testQueriedAuthorHasSelfAsAvatar() {
		let avatar: Avatar! = queriedAvatar.author.avatar!
		XCTAssertTrue(avatar as AnyObject === queriedAvatar as AnyObject)
	}
}

class QueriedUserTests: XCTestCase {
	var queriedUser: User!

    override func setUp() {
        super.setUp()
		queriedUser = DependencyContainer.setup().resolve(User.self)!
		queriedUser.show(uid: 42)
    }
    override func tearDown() {
        super.tearDown()
    }
    
    func testQueriedUserIsValid() {
		XCTAssertTrue(queriedUser.isValid())
    }
    func testQueriedAvatarIsNotNil() {
		XCTAssertNotNil(queriedUser.avatar)
	}
    func testQueriedAvatarHasSelfAsAuthor() {
		let user: User! = queriedUser.avatar.author
		XCTAssertTrue(user as AnyObject === queriedUser as AnyObject)
	}
}

class NewUserAndAvatarTests: XCTestCase {
	var newUser: User!
	var newAvatar: Avatar!

    override func setUp() {
        super.setUp()
		let exp = expectation(description: "\(#function)\(#line)")

		let container = DependencyContainer.setup()
		newUser = container.resolve(User.self, argument: "test001")!
		newAvatar = container.resolve(Avatar.self, argument: newUser!)!

		newAvatar.create(completion: { error in
			self.newUser.avatar = self.newAvatar
			self.newUser.create(completion: { error in
				exp.fulfill()
			})
		})

		waitForExpectations(timeout: 60, handler: nil)
	}
    override func tearDown() {
        super.tearDown()
    }

    func testNewUserIsValid() {
		XCTAssertTrue(newUser.isValid())
    }
    func testNewAvatarIsValid() {
		XCTAssertTrue(newAvatar.isValid())
    }
    func testNewAvatarHasNewUser() {
		let author: User! = newAvatar.author
		XCTAssertTrue(author as AnyObject === newUser as AnyObject)
	}
    func testNewUserHasNewAvatar() {
		let avatar: Avatar! = newUser.avatar
		XCTAssertTrue(avatar as AnyObject === newAvatar as AnyObject)
	}
}

class PerformanceTests: XCTestCase {
	let kLoop = 10000

    override func setUp() {
        super.setUp()
		DependencyContainer.setup()
    }
    override func tearDown() {
        super.tearDown()
    }

    func testPerformanceSetup() {
        self.measure {
			for _ in 0 ..< self.kLoop {
				DependencyContainer.setup()
			}
        }
    }
    func testPerformanceResolve() {
        self.measure {
			for _ in 0 ..< self.kLoop {
				let _ = DependencyContainer.container.resolve(Avatar.self)!
			}
        }
    }
    func testPerformanceCompare() {
        self.measure {
			for _ in 0 ..< self.kLoop {
				let _ = MockAvatar()
			}
        }
    }
    func testPerformanceEmpty() {
        self.measure {
			for _ in 1 ..< 10000 {
			}
        }
    }
}
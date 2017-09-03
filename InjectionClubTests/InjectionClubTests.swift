//
//  InjectionClubTests.swift
//  InjectionClubTests
//
//  Created by Leo Liu on 8/22/17.
//  Copyright © 2017 Swine Reader Community. All rights reserved.
//

import XCTest
@testable import InjectionClub

class QueriedAvatarTests: XCTestCase {
  var queriedAvatar: Avatar!
  
  override func setUp() {
    super.setUp()
    DIManager.setup()
    queriedAvatar = DIManager.initAvatar()
    queriedAvatar.query(uid: 42)
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
    DIManager.setup()
    queriedUser = DIManager.initUser()
    queriedUser.query(uid: 42)
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
    let user: User! = queriedUser.avatar?.author
    XCTAssertTrue(user as AnyObject === queriedUser as AnyObject)
  }
}

class NewUserAndAvatarTests: XCTestCase {
  var newUser: User!
  var newAvatar: Avatar!
  
  override func setUp() {
    super.setUp()
    let exp = expectation(description: "\(#function)\(#line)")
    
    DIManager.setup()
    newUser = DIManager.initUser(username: "test001")
    newAvatar = DIManager.initAvatar(author: newUser)
    
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
  func testNewUserHasUsername() {
    XCTAssertNotNil(newUser.username)
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

class NewUserAndAvatarWithoutDITests: XCTestCase {
  var newUser: User!
  var newAvatar: Avatar!
  
  override func setUp() {
    super.setUp()
    let exp = expectation(description: "\(#function)\(#line)")
    
    let userType: User.Type = MockUser.self
    let avatarType: Avatar.Type = MockAvatar.self
    
    newUser = userType.init(username: "test001")
    newAvatar = avatarType.init(author: newUser)
    
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
  func testNewUserHasUsername() {
    XCTAssertNotNil(newUser.username)
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
    DIManager.setup()
  }
  override func tearDown() {
    super.tearDown()
  }
  
  func testPerformanceSetup() {
    self.measure {
      for _ in 0 ..< self.kLoop {
        DIManager.setup()
      }
    }
  }
  func testPerformanceResolve() {
    self.measure {
      for _ in 0 ..< self.kLoop {
        let _ = DIManager.container.resolve(Avatar.self)!
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

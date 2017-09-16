/**
* Copyright (c) 2017 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish, 
* distribute, sublicense, create a derivative work, and/or sell copies of the 
* Software in any work that is designed, intended, or marketed for pedagogical or 
* instructional purposes related to programming, coding, application development, 
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works, 
* or sale is expressly withheld.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import XCTest
@testable import InjectionClub

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

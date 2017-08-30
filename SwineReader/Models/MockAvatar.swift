class MockAvatar: Avatar {
	var uid = -1
	var imageURL = "http://www.superarts.org/swine/default.png"
	var author: User!

	required init() {
	}
	required init(author: User) {
		self.author = author
	}

	func create(completion: ErrorClosure? = nil) {
		uid = 1
		if let closure = completion {
			closure(nil)
		}
	}
	func query(uid: Int) {
		self.uid = uid
		imageURL = String(format: "http://test.com/image%03d.png", uid)

		var user = DIManager.initUser()
		user.query(uid: 42)
		user.avatar = self
		author = user
	}
}
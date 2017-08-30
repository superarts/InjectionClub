class MockUser: User {
	var uid = -1
	var username: String!
	var avatar: Avatar?

	required init() {
	}
	required init(username: String) {
		self.username = username
	}

	func create(completion: ErrorClosure? = nil) {
		uid = 1
		if let closure = completion {
			closure(nil)
		}
	}
	func query(uid: Int) {
		self.uid = uid
		username = String(format: "test%03d", uid)

		let avatar = DIManager.initAvatar(author: self)
		avatar.create()
		self.avatar = avatar
	}
}
protocol Presentable: Indexable {
	func create(completion: ErrorClosure?)
	func query(uid: Int)
}

extension Presentable {
	func create(completion: ErrorClosure? = nil) {
		create(completion: completion)
	}
}
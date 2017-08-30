protocol Indexable {
	var uid: Int { get set }
	func isValid() -> Bool
}

extension Indexable {
	func isValid() -> Bool {
		return uid >= 0
	}
}
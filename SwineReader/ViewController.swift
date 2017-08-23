import UIKit
import Swinject

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
		setupDI()
	}
	func setup() {
		let user = MockUser()
		user.username = "test001"

		let avatar = MockAvatar(author: user)
		avatar.imageURL = "http://www.superarts.org/swine/default.png"
		avatar.create()

		user.avatar = avatar
		user.create()

		print("====")
		print("User: \(user)")
		print("is valid: \(user.isValid())")
		print("username: \(user.username)")
		print("avatar: \(user.avatar)")
		print("----")

		print("Avatar: \(avatar)")
		print("is valid: \(avatar.isValid())")
		print("image URL: \(avatar.imageURL)")
		print("author: \(avatar.author)")
		print("----")
	}
	func setupDI() {
		let container = DependencyContainer.setup()

		var user = container.resolve(User.self)!
		user.username = "test001"

		var avatar = container.resolve(Avatar.self, argument: user)!
		avatar.imageURL = "http://www.superarts.org/swine/default.png"
		avatar.create()

		user.avatar = avatar
		user.create()

		print("User: \(user), \(user.isValid())")
		print("Avatar: \(avatar), \(avatar.isValid())")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
	}
}

protocol Indexable {
	var uid: Int { get set }
	func isValid() -> Bool
}

extension Indexable {
	func isValid() -> Bool {
		return uid >= 0
	}
}

protocol Presentable: Indexable {
	func create()
	func show(uid: Int)
}

protocol Avatar: Presentable {
	var imageURL: String! { get set }
	var author: User! { get set }
	
	init()
	init(author: User)
}

class MockAvatar: Avatar {
	var uid = -1
	var imageURL: String!
	var author: User!

	required init() {
	}
	required init(author: User) {
		self.author = author
	}

	func create() {
		uid = 1
	}
	func show(uid: Int) {
		self.uid = uid
		imageURL = String(format: "http://test.com/image%03d.png", uid)
	}
}

protocol User: Presentable {
	var username: String! { get set }
	var avatar: Avatar! { get set }
}

class MockUser: User {
	var uid = -1
	var username: String!
	var avatar: Avatar!

	func create() {
		uid = 1
	}
	func show(uid: Int) {
		self.uid = uid
		username = String(format: "test%03d", uid)
	}
}

extension MockUser: CustomStringConvertible {
    var description: String {
        return "MockUser: (\(uid), \(username))"
    }
}

protocol Post: Presentable {
	var title: String! { get set }
}

class DependencyContainer {
	static let container = Container()
	static func setup() -> Container {
		container.register(User.self) { _ in MockUser() }
		container.register(Avatar.self) { _, user in MockAvatar(author: user) }
		return container
	}
}
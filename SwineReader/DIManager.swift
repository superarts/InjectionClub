import Swinject

struct DIManager {
  static let container = Container()
  
  @discardableResult
  static func setup() -> Container {
    container.register(User.self) { _ in MockUser() }
    container.register(User.self) { _, username in MockUser(username: username) }
    container.register(Avatar.self) { _ in MockAvatar() }
    container.register(Avatar.self) { _, user in MockAvatar(author: user) }
    return container
  }
  
  static func initUser() -> User {
    return container.resolve(User.self)!
  }
  
  static func initUser(username: String) -> User {
    return container.resolve(User.self, argument: username)!
  }
  
  static func initAvatar() -> Avatar {
    return container.resolve(Avatar.self)!
  }
  
  static func initAvatar(author: User) -> Avatar {
    return container.resolve(Avatar.self, argument: author)!
  }
}

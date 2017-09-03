protocol User: Presentable, CustomStringConvertible {
  var username: String! { get set }
  var avatar: Avatar? { get set }

  init()
  init(username: String)
}
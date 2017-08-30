protocol Avatar: Presentable, CustomStringConvertible {
  var imageURL: String { get set }
  var author: User! { get set }
  
  init()
  init(author: User)
}
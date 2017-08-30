public typealias ErrorClosure = ((Error?) -> Void)

func debugAddr(_ obj: Any) -> UnsafeMutableRawPointer {
  return Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque()
}
extension MockUser: CustomStringConvertible {
  var description: String {
    return "MockUser \(debugAddr(self)):\n\tID: \(uid)\n\tusername: \(username)\n\tavatar: \(avatar != nil ? avatar!.description : "nil")\n\tvalidity: \(isValid())\n"
  }
}

extension MockAvatar: CustomStringConvertible {
  var description: String {
    return "MockAvatar \(debugAddr(self)):\n\tID: \(uid)\n\timageURL: \(imageURL)\n\tauthor: \(debugAddr(author))\n\tvalidity: \(isValid())\n"
  }
}

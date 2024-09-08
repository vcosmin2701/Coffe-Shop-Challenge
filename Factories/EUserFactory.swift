class EUserFactory {
  static func createUser(xCoordinate: Double, yCoordinate: Double) -> EUser {
    return EUser(xCoordinate: xCoordinate, yCoordinate: yCoordinate)
  }
}
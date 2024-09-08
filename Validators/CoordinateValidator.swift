protocol CoordinateValidator {
  func isValid(x: Double, y: Double) -> Bool
}

class CoordinateValidatorImpl: CoordinateValidator{
  func isValid(x: Double, y: Double) -> Bool {
    return x >= -180 && x <= 180 && y >= -90 && y <= 90 
  }
}
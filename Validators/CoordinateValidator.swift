protocol CoordinateValidator {
  func isValid(x: Double, y: Double) -> Bool
}

// Checked the max value of coordinates, and decided for this
// implementation that x and also y can be arround this range [-180, 180]
// for future implementation, maybe based on a real API, things
// will be different

class CoordinateValidatorImpl: CoordinateValidator{
  func isValid(x: Double, y: Double) -> Bool {
    return x >= -180 && x <= 180 && y >= -180 && y <= 180
  }
}
import Foundation

// MARK: - ImageDataValue
struct ImageDataValue: Codable, Comparable, Identifiable {
  static func < (lhs: ImageDataValue, rhs: ImageDataValue) -> Bool {
    lhs.self < rhs.self
  }
  
  let id = UUID().uuidString
  let photoURL, userURL: String?
  let userName: String?
  let colors: [String]?
  
  enum CodingKeys: String, CodingKey {
    case photoURL = "photo_url"
    case userURL = "user_url"
    case userName = "user_name"
    case colors
  }
}

typealias ImageData = [String: ImageDataValue]

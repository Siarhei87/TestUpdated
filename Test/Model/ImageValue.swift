import Foundation

// MARK: - ImageDataValue
struct ImageDataValue: Codable, Identifiable {
  let id = UUID().uuidString
  let photoURL: String?
  let userURL: String?
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

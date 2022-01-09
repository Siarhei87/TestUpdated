import Foundation

class Api {
  
  func getInfo(completion: @escaping (ImageData) -> ()) {
    
    guard let url = URL(string: "http://dev.bgsoft.biz/task/credits.json") else {
      return
    }
        
    /// Запрос на загрузку URL-адреса
    let request = URLRequest(url: url)
    
    URLSession.shared.dataTask(with: request) { data, response, error in
      
      // #warning!
      if let data = data {
        do {
          /// Константа, в которую записывается декодированный ответ
          let decodedResponse = try JSONDecoder().decode(ImageData.self, from: data)
          
          completion(decodedResponse)
        } catch let DecodingError.dataCorrupted(context) {
          print(context)
        } catch let DecodingError.keyNotFound(key, context) {
          print("Key '\(key)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
          print("Value '\(value)' not found:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
          print("Type '\(type)' mismatch:", context.debugDescription)
          print("codingPath:", context.codingPath)
        } catch {
          print("error: ", error)
        }
      }
    }.resume()
  }
}

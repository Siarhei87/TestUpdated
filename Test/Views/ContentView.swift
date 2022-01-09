import SwiftUI

struct ContentView: View {
  
  @State var content: ImageData = ImageData()
  
  var body: some View {
    
    List {
      ForEach(content.sorted(by: >), id: \.key) { key, value in
        HStack {
          Text(value.userName!)
          Spacer()
          CustomImageView(fullImageUrlByName(key))
        }
      }
    }
    
    .onAppear() {
      Api().getInfo { receivedData in
        self.content = receivedData
      }
    }
  }
  
  func fullImageUrlByName(_ name: String) -> String {
    "http://dev.bgsoft.biz/task/" + name + ".jpg"
  }
}


struct CustomImageView: View {
  
  @ObservedObject var imageLoader = ImageLoaderService()
  
  @State var image: UIImage = UIImage()
  
  let fullImageLink: String
  
  init(_ fullImageLink: String) {
    self.fullImageLink = fullImageLink
  }
  
  var body: some View {
    Image(uiImage: image)
      .resizable()
      .aspectRatio(1, contentMode: .fit)
    
      .onReceive(imageLoader.$image) { image in
        self.image = image
      }
    
      .onAppear {
        imageLoader.loadImage(for: fullImageLink)
      }
  }
}

class ImageLoaderService: ObservableObject {
  @Published var image: UIImage = UIImage()
  
  func loadImage(for urlString: String) {
    guard let url = URL(string: urlString) else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      guard let data = data else { return }
      DispatchQueue.main.async {
        self.image = UIImage(data: data) ?? UIImage()
      }
    }
    task.resume()
  }
}

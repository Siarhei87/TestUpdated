import SwiftUI

struct ContentView: View {
  
  @State var images: [ImageDataValue] = []
  
  var body: some View {
    
    List {
      ForEach(images) { image in
        
        
          
          Text(image.userName ?? "")
          
        
      }
    }
    
    .onAppear() {
      Api().getInfo { imageData in
        imageData.values.forEach { imageDataValue in
          self.images.append(imageDataValue)
        }
      }
    }
  }
}

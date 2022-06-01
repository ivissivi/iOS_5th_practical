import SwiftUI

struct ImagesView: View {
    let columns = [
        GridItem(.fixed(130)),
        GridItem(.fixed(130)),
        GridItem(.fixed(130))]
    
    @State var images = [Image]()
    @State var inputImage: UIImage?
    
    @State var selectedImageIndex = 0
    
    @State var showingImagePicker = false
    @State var viewingImage = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Images")
                    .font(.system(size: 25, weight: .medium))
                
                Spacer()
                
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus.app")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.purple)
                }
            }
            .frame(height: 30)
            .padding(.horizontal, 10)
            Divider()
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(images.indices, id: \.self) { index in
                        images[index]
                            .resizable()
                            .frame(width: 130, height: 130)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedImageIndex = index
                                viewingImage = true
                            }
                    }
                }
            }
            .padding()
        }
        .onChange(of: inputImage, perform: { _ in LoadImage() })
        .sheet(isPresented: $showingImagePicker, content: {
            ImagePicker(image: $inputImage)
        })
        .sheet(isPresented: $viewingImage) {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [.pink, .purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    images[selectedImageIndex]
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .padding()
                        .shadow(radius: 25)
                    
                    
                    Button {
                        viewingImage = false
                    } label: {
                        Text("Close")
                            .bold()
                            .font(.title2)
                            .frame(width: 300, height: 60)
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [.cyan,.blue], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
    
    func LoadImage() {
        guard let inputImage = inputImage else { return }
        let image = Image(uiImage: inputImage)
        images.append(image)
    }
}

struct ImagesView_Previews: PreviewProvider {
    static var previews: some View {
        ImagesView()
    }
}

import SwiftUI
import AVKit
import AVFoundation

struct VideosView: View {
    
    let columns = [
        GridItem(.fixed(130)),
        GridItem(.fixed(130)),
        GridItem(.fixed(130))]
    
    @State var thumbnails = [Image]()
    @State var videosLocation = [URL]()
    
    @State var inputVideoPath = ""

    @State var selectedVideoIndex = 0
    
    @State var videoPlayer = AVPlayer()
    
    @State var vieweingVideo = false
    @State var showingVideoPicker = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Videos")
                    .font(.system(size: 25, weight: .medium))
                
                Spacer()
                
                Button {
                    showingVideoPicker = true
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
                    ForEach(thumbnails.indices, id: \.self) { index in
                        thumbnails[index]
                            .resizable()
                            .frame(width: 130, height: 130)
                            .cornerRadius(10)
                            .onTapGesture {
                                selectedVideoIndex = index
                                vieweingVideo = true
                            }
                    }
                }
            }
            .padding()
        }
        .onChange(of: inputVideoPath, perform: { _ in LoadVideo() })
        .sheet(isPresented: $showingVideoPicker, content: {
            VideoPicker(videoURL: $inputVideoPath)
        })
        .sheet(isPresented: $vieweingVideo) {
            VideoPlayer(player: videoPlayer)
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    videoPlayer = AVPlayer(url: videosLocation[selectedVideoIndex])
                }
        }
        
    }
    
    func GetThumbnailFromVideo(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: url)
            let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            avAssetImageGenerator.appliesPreferredTrackTransform = true
            let thumnailTime = CMTimeMake(value: 2, timescale: 1)
            do {
                let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
                let thumbNailImage = UIImage(cgImage: cgThumbImage)
                DispatchQueue.main.async {
                    completion(thumbNailImage)
                }
            }
            catch {
                print(error.localizedDescription)
                DispatchQueue.main.async
                {
                    completion(nil)
                }
            }
        }
    }
    
    func LoadVideo() {
        videosLocation.append(URL(string: inputVideoPath)!)
        
        GetThumbnailFromVideo(url: URL(string: inputVideoPath)!) { (thumbNailImage) in
            thumbnails.append(Image(uiImage: thumbNailImage!))
        }
    }
}

struct VideosView_Previews: PreviewProvider {
    static var previews: some View {
        VideosView()
    }
}

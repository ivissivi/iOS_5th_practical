import PhotosUI
import SwiftUI

struct VideoPicker: UIViewControllerRepresentable {
    
    @Binding var videoURL: String
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .videos
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: VideoPicker
        
        init(_ parent: VideoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            {}
            
            guard let provider = results.first?.itemProvider else {return}
            provider.loadFileRepresentation(forTypeIdentifier: UTType.movie.identifier) { url, error in
                guard error == nil else {
                    print(error!)
                    return
                }
    
                guard let url = url else {return}
                
                let fileName = "\(Int(Date().timeIntervalSince1970)).\(url.pathExtension)"
                
                let newUrl = URL(fileURLWithPath: NSTemporaryDirectory() + fileName)
                
                try? FileManager.default.copyItem(at: url, to: newUrl)
                self.parent.videoURL = newUrl.absoluteString
            }
        }
    }
}

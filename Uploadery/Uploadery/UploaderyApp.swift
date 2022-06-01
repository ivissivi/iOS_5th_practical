import SwiftUI

@main
struct UploaderyApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            SignInView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

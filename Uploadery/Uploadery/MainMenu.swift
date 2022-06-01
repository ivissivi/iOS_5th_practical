import SwiftUI

struct MainMenu: View {
    
    let userEmail: String
    @State public var selected = 0
    
    var body: some View {
        TabView (selection: $selected) {
            ImagesView()
                .tabItem {
                    Image(systemName: "photo")
                        .scaledToFit()
                }
                .tag(0)
            
            VideosView()
                .tabItem {
                    Image(systemName: "video.circle")
                        .scaledToFit()
                }
                .tag(1)
            
            MyProfileView(userEmail: userEmail)
                .tabItem {
                    Image(systemName: "person.crop.circle")
                        .scaledToFit()
                }
                .tag(2)
        }
        .navigationTitle("Uploadery")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            // correct the transparency bug for Tab bars
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }        
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(userEmail: "test")
    }
}

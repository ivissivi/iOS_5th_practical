import SwiftUI

struct SplashView: View {
    // When true it hides the splash screen elements, false means it's in progress, so it shows the UI
    @State var finished = false
    
    var body: some View {
        
        ZStack {
            if !finished {
                Image("HomeBackground")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Text("Uploadery")
                        .foregroundColor(.white)
                        .font(.system(size: 70))
                        .bold()
                        .padding(.bottom,50)
                }
                .frame(maxHeight: .infinity)
            }
            
        }
        .onAppear {
            // Once the screen loads we add a two seconds delay to hide the splash screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                finished.toggle()
            }
        }
    }
}

struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}

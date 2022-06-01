import SwiftUI

struct MyProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @State var firstGradient = Gradient(colors: [.purple, .pink])
    @State var secondGradient = Gradient(colors: [.blue, .mint])
    @State var toggleGradient = true
    
    @State var rotationAngle: Double = 0
    
    let colorList = [Color.red,Color.orange,Color.yellow,Color.green,Color.mint,Color.teal,Color.cyan,Color.blue,Color.indigo,Color.purple,Color.pink,Color.brown]
    
    let userEmail: String
    
    var body: some View {
        VStack {
            VStack {
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .foregroundColor(.white)
                
                Text(String(userEmail))
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    SwitchColors()
                } label: {
                    Text("Switch Color")
                        .bold()
                        .font(.title2)
                        .frame(width: 300, height: 60)
                        .foregroundColor(.white)
                        .background(.black)
                        .cornerRadius(20)
                }
                
                Spacer()
                
            }
            .frame(width: 428, height: 400)
            .background(
                VStack {
                    if toggleGradient {
                        LinearGradient(gradient: firstGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .transition(.slide)
                    } else {
                        LinearGradient(gradient: secondGradient, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .transition(.slide)
                    }
                }
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeIn))
            
            Spacer()
            
            Spacer()
            
            Button {
                dismiss()
            } label: {
                Text("Sign out")
                    .bold()
                    .font(.title2)
                    .frame(width: 300, height: 60)
                    .foregroundColor(.white)
                    .background(LinearGradient(colors: [.blue,.cyan], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(20)
            }
            Spacer()
        }
    }
    
    func SwitchColors() {
        let newGradient = Gradient(colors: [colorList[Int.random(in: 0...11)],colorList[Int.random(in: 0...11)]])
        
        if !toggleGradient {
            firstGradient = newGradient
        } else {
            secondGradient = newGradient
        }
        
        toggleGradient.toggle()
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView(userEmail: "test@test.com")
    }
}

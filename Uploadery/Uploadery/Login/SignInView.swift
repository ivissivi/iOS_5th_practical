import SwiftUI

struct SignInView: View {

    @State var email: String = ""
    @State var password: String = ""
    
    @State var canContinue: Bool = false
    
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Account>
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: MainMenu(userEmail: email), isActive: $canContinue) { EmptyView() }
                
                VStack {
                    VStack {
                        Text("Welcome")
                            .font(.title)
                            .bold()
                            .padding(.bottom,5)
                        
                        Text("We're happy to see you again")
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    VStack {
                        TextField("Email", text: $email)
                            .frame(height: 50)
                            .padding(.horizontal, 6)
                            .background(Color("LightGray"))
                            .textContentType(.emailAddress)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                        
                        TextField("Password", text: $password)
                            .frame(height: 50)
                            .padding(.horizontal, 6)
                            .background(Color("LightGray"))
                            .textContentType(.password)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                    }
                    .padding(.horizontal,20)
                    .padding(.bottom,50)
                    
                    Spacer()
                    
                    Button {
                        if !email.isEmpty && !password.isEmpty {
                            users.forEach { user in
                                if user.email == email && user.password == password {
                                    canContinue = true
                                }
                            }
                        }
                    } label: {
                        Text("Sign in")
                            .bold()
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(LinearGradient(colors: [.red,.purple], startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(10)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: SignUpView(), label: {
                        Text("Don't have an account? Sign Up")
                            .foregroundColor(.pink)
                            .bold()
                            .padding()
                    })
                }
            }
            .navigationTitle("Sign In")
        }
        .overlay {
            SplashView()
                .animation(.spring())
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

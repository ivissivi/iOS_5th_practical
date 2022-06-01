import SwiftUI

struct SignUpView: View {

    @Environment(\.dismiss) var dismiss
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<Account>
    
    @State var email: String = ""
    @State var password: String = ""
    @State var repeatPassword: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text("Create an account")
                    .font(.title)
                    .bold()
                    .padding(.bottom,5)
                
                Text("Sign up to see photos and videos\nfrom your friends.")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack {
                TextField("Email*", text: $email)
                    .frame(height: 50)
                    .padding(.horizontal, 6)
                    .background(Color("LightGray"))
                    .textContentType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("Password*", text: $password)
                    .frame(height: 50)
                    .padding(.horizontal, 6)
                    .background(Color("LightGray"))
                    .textContentType(.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                
                TextField("Repeat password*", text: $repeatPassword)
                    .frame(height: 50)
                    .padding(.horizontal, 6)
                    .background(Color("LightGray"))
                    .textContentType(.password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            .padding(.horizontal,20)
            
            Spacer()
            
            Button {
                if !email.isEmpty && !password.isEmpty && password.elementsEqual(repeatPassword) {
                    var registeredEmail = false
                    
                    users.forEach { user in
                        if user.email == email {
                            registeredEmail = true
                            return
                        }
                    }
                    
                    if registeredEmail {
                        return
                    }
                    
                    let user = Account(context: managedObjectContext)
                    user.id = UUID()
                    user.email = email
                    user.password = password
                    
                    try? managedObjectContext.save()
                    
                    dismiss()
                }
                
                dismiss()
            } label: {
                Text("Sign up")
                    .bold()
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .background(LinearGradient(colors: [.red,.purple], startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(10)
            }
            
            Text("By proceeding you also agree to Terms of Service and Privacy Policy")
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
            
            NavigationLink(destination: SignInView(), label: {
                Button {
                    dismiss()
                } label: {
                    Text("Already have an account? Sign in")
                        .bold()
                        .foregroundColor(.pink)
                        .padding()
                }
            })
                .padding()
        }.navigationTitle("Sign Up")
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

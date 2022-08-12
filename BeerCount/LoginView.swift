//
//  LoginView.swift
//  BeerCount
//
//  Created by Eduardo Ximenes on 10/08/22.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var userIsLoggedIn = false
    
    var body: some View {
        if userIsLoggedIn == false {
            loginPage
        } else {
            HomePage()
        }
    }
    
    
    var loginPage: some View {
        ZStack{
            Color.black
            RoundedRectangle(cornerRadius: 30, style: .continuous)
                .foregroundStyle(.linearGradient(colors:[.yellow, .orange],
                        startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 1000, height: 500)
                .rotationEffect(.degrees(45))
                .offset(x: 100, y:-300)
            VStack(spacing: 20){
                Text("Welcome")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .offset(y: -100)
                TextField("Email", text: $email)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: email.isEmpty) {
                        Text("Email")
                            .foregroundColor(.white)
                            .bold()
                    }
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                SecureField("Password", text: $password)
                    .foregroundColor(.white)
                    .textFieldStyle(.plain)
                    .placeholder(when: password.isEmpty){
                        Text("Password")
                            .foregroundColor(.white)
                            .bold()
                    }
                
                Rectangle()
                    .frame(width: 350, height: 1)
                    .foregroundColor(.white)
                
                Button {
                    login()
                } label: {
                    Text("Sign in")
                        .bold()
                        .frame(width: 200, height: 40)
                        .background(
                            RoundedRectangle(cornerRadius: 20, style: .continuous)
                                .fill(.linearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottomTrailing))
                        )
                }
                .foregroundColor(.white)
                .padding(.top)
                .offset(y: 50)
                
                Button{
                    register()
                }label: {
                    Text("Don't have an account? Register")
                        .bold()
                        .foregroundColor(.white)
                }
                .frame(width: 200, height: 40)
                .offset(y: 50)

                
            }
            .frame(width:350)
            .onAppear{
                Auth.auth().addStateDidChangeListener{auth, user in
                    if user != nil {
                        userIsLoggedIn.toggle()
                    }
                }
            }
            
        }
        .ignoresSafeArea()
    }
    
    func login(){
        Auth.auth().signIn(withEmail: email, password: password){
            result, error in if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func register(){
        Auth.auth().createUser(withEmail: email, password: password){
            result, error in if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

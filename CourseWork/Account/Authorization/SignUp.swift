//
//  SignUp.swift
//  CourseWork
//
//  Created by Andrew Landiak on 09.05.2022.
//

import SwiftUI
import Firebase

struct SignUp : View {
    @ObservedObject var signUp = SignUpViewModel()
    
    @State var color = Color.black.opacity(0.7)
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    @State var pass = ""
    @State var repass = ""
    @State var visible = false
    @State var revisible = false
    @Binding var show : Bool
    @State var alert = false
    @State var error = ""

    
    var body: some View{
        
        ZStack{
                GeometryReader{_ in
                    VStack{
                        Text("Register")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding(.top, 25)

                        TextField("Email", text: self.$email)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.email != "" ? Color("AppColor") : self.color,lineWidth: 2))
                        .padding(.top, 45)
                        
                        HStack(spacing: 15) {
                            VStack {
                                if self.visible{
                                    TextField("Password", text: self.$pass).autocapitalization(.none)
                                } else{
                                    SecureField("Password", text: self.$pass).autocapitalization(.none)
                                }
                            }
                            Button(action: {self.visible.toggle()}) {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.pass != "" ? Color("AppColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        HStack(spacing: 15) {
                            VStack {
                                if self.revisible{
                                    TextField("Re-password", text: self.$repass)
                                    .autocapitalization(.none)
                                } else{
                                    SecureField("Re-password", text: self.$repass)
                                    .autocapitalization(.none)
                                }
                            }
                            
                            Button(action: {
                                self.revisible.toggle()
                            }) {
                                Image(systemName: self.revisible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.repass != "" ? Color("AppColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        TextField("First name", text: self.$firstName)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.firstName != "" ? Color("AppColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        TextField("Last name", text: self.$lastName)
                        .autocapitalization(.none)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 4).stroke(self.lastName != "" ? Color("AppColor") : self.color,lineWidth: 2))
                        .padding(.top, 25)
                        
                        
                        Button(action: {
                            self.register()
                        }) {
                            Text("Sign up")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("AppColor"))
                        .cornerRadius(30)
                        .padding(.top, 60)
                        
                        Button(action: {
                            self.show.toggle()
                            
                        }) {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        }
                        .background(Color("AppColor"))
                        .cornerRadius(30)
                        .padding(.top, 5)
                        
                    }
                    .padding(.horizontal, 25)
                }
            
            if self.alert{
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    func register() {
        if self.email != "" {
            if self.pass == self.repass {
                if self.lastName == "" || self.firstName == "" {
                    self.error = "First name and last name have to be fulfilled "
                    self.alert.toggle()
                } else {
                    Auth.auth().createUser(withEmail: self.email, password: self.pass) { (res, err) in
                        if err != nil{
                            self.error = err!.localizedDescription
                            self.alert.toggle()
                            return
                        }
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    }
                }
                signUp.saveInformation(info: self.firstName + " " + self.lastName, user: self.email)
                
            }
            else {
                self.error = "Password mismatch"
                self.alert.toggle()
            }
        }
        else {
            self.error = "Please fill all the contents properly"
            self.alert.toggle()
        }
    }
}

//
//  AccountView.swift
//  CourseWork
//
//  Created by Andrew Landiak on 03.05.2022.
//

import Foundation
import SwiftUI
import Firebase

struct AccountView: View {
    @ObservedObject var accountVM = AccountViewModel()
    @ObservedObject var signUp = SignUpViewModel()
    
    @State var showActionSheet: Bool = false
    @State var showImagePicker: Bool = false
    @State var notDeleted: Bool = true
    @State var selectedImage: UIImage? = UIImage(contentsOfFile: "")
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    private let user = Auth.auth().currentUser?.email ?? ""
    
    var body: some View {
        VStack {
            AccountManagerHeader()
            Button {
                self.showActionSheet = true
            } label: {
                if selectedImage != UIImage(contentsOfFile: "") {
                    Image(uiImage: self.selectedImage!).resizable().clipShape(Circle()).frame(width: 200, height: 200).overlay(Circle().stroke(Color("AppColor"), lineWidth: 3))
                } else {
                    Image(uiImage: self.accountVM.getPhoto(user: user)).resizable().clipShape(Circle()).frame(width: 200, height: 200).overlay(Circle().stroke(Color("AppColor"), lineWidth: 3))
                }

            }
            .frame(width:200, height: 200)
            .padding(.top, 20)
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(title: Text("Add photo"), buttons: [
                                .default(Text("Choose from library"), action: {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                }),
                                .default(Text("Delete photo"), action: {
                                    notDeleted = false
                                    self.selectedImage = UIImage(contentsOfFile: "")
                                    accountVM.deletePhoto(user: self.user)
                                }),
                    .cancel()
                ])
            }.accentColor(Color("AppColor")).onChange(of: selectedImage) { [] newState in
                accountVM.savePhoto(photo: (self.selectedImage != nil ? self.selectedImage! : UIImage(systemName: "person")!), user: self.user)
            }
            Text(signUp.getInformation(user: user)).foregroundColor(Color("GreenColor"))
                .mainTitle()
                .font(.system(size: 25))
                .padding(.top, 20)
            Spacer()
            VStack(spacing: 50) {
                Button(action: {
                    print("Settings")
                }) {
                    Text("Settings")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }
                .background(Color("AppColor"))
                .cornerRadius(10)
                
                Button(action: {
                    try! Auth.auth().signOut()
                    UserDefaults.standard.set(false, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                    
                }) {
                    Text("Log out")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                }            .background(Color("AppColor"))
                    .cornerRadius(10)
            }
            .padding(.bottom, 130)
        }
        .sheet(isPresented: $showImagePicker, content: {
            ImagePicker(image: self.$selectedImage)
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color(red: 0.9843113725490196, green: 0.9294117647058824, blue: 0.8470588235294118))
    }
}

struct AccountManagerHeader: View {
    var body: some View {
        VStack {
            Text("Personal account")
                .mainTitle()
                .frame(minWidth: 0, maxWidth: .infinity)
                .font(.system(size: 30))
            Rectangle()
                .frame(maxWidth: UIScreen.screenWidth - 70, maxHeight: 2)
                .foregroundColor(Color("GreenColor"))
                .cornerRadius(10)
        }.frame(width: UIScreen.screenWidth, height: 80)
         .padding(.top, 40)
    }
}

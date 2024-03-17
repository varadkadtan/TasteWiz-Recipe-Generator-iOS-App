//
//  SignInPage.swift
//  TasteWiz
//
//  Created by user46a on 30/12/23.
//

import SwiftUI

struct SignInPage: View {
    @State private var password: String = ""
    @State private var username: String = ""
    var body: some View {
        
        
            
            VStack{
                ZStack {
                    VStack{
                        HStack{
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 40, height: 38)
                                .background(
                                    Image("Image 11")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 40, height: 38)
                                        .clipped()
                                    
                                )
                                .cornerRadius(4)
                                .offset(x:-120)
                            
                            Text("Register")
                                .font(Font.custom("Inter", size: 16))
                                .foregroundColor(Color(red: 0.48, green: 0.35, blue: 0))
                                .offset(x:120)
                        }//Hstack
                        
                        Text("Sign In")
                            .font(
                                Font.custom("Epilogue", size: 36)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                            .offset(x:-99,y:140)
                        
                        Text("Welcome back! Let's get cooking. Sign in now.")
                            .font(Font.custom("Inter", size: 16))
                            .foregroundColor(Color(red: 0.43, green: 0.31, blue: 0))
                            .frame(width: 306, alignment: .topLeading)
                            .offset(y:150)
                    }//VSTACK
                } //zstack
                .frame(width: 462, height: 460)
                .background(Color(red: 0.99, green: 0.71, blue: 0))
                
                .cornerRadius(80)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                .shadow(color: .black.opacity(0.1), radius: 7.75, x: 0, y: 8)
                .offset(y:-250)
                //  .padding(.bottom, )
                
                HStack(alignment: .center, spacing: 0) {
                    TextField("Username", text: $username)
                        .font(Font.custom("Inter", size: 14))
                        .foregroundColor(Color(red: 0.74, green: 0.76, blue: 0.79))
                }
                .padding(.leading, 51)
                .padding(.trailing, 200)
                .padding(.top, 27.12836)
                .padding(.bottom, 24.87164)
                .frame(width: 350, height: 74, alignment: .leading)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                .cornerRadius(37)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                .shadow(color: .black.opacity(0.1), radius: 10.05, x: 0, y: 8)
                .offset(y:-230)
                
                HStack(alignment: .center, spacing: 0) { TextField("Password", text: $password)
                        
                        
                        .font(Font.custom("Inter", size: 14))
                    .foregroundColor(Color(red: 0.74, green: 0.76, blue: 0.79))}
                .padding(.leading, 51)
                .padding(.trailing, 200)
                .padding(.top, 28.12836)
                .padding(.bottom, 22.87164)
                .frame(width: 350, height: 73, alignment: .leading)
                .background(Color(red: 0.96, green: 0.96, blue: 0.96))
                .cornerRadius(37)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                .shadow(color: .black.opacity(0.1), radius: 10.05, x: 0, y: 8)
                .offset(y:-225)
                
                Text("Forgot Password?")
                    .font(Font.custom("Inter", size: 14))
                    .foregroundColor(Color(red: 0.56, green: 0.58, blue: 0.63))
                    .offset(x:110,y:-220)
                
         //       NavigationLink(destination: ContentView()) {
                
                    HStack(alignment: .center, spacing: 0) {
                        NavigationLink(destination: ContentView()) {
                            Text("Sign In")}
                        .navigationBarBackButtonHidden(true)
                            .font(Font.custom("Inter", size: 16))
                        .foregroundColor(Color(red: 0.74, green: 0.76, blue: 0.79)) }
                    .padding(.leading, 158)
                    .padding(.trailing, 168)
                    .padding(.top, 22.62836)
                    .padding(.bottom, 25.37164)
                    .frame(width: 378, alignment: .leading)
                    .background(.black)
                    .cornerRadius(37)
                    .shadow(color: .black.opacity(0.15), radius: 8.5, x: 0, y: 8)
                    .shadow(color: .black.opacity(0.12), radius: 1, x: 0, y: 0)
                    .shadow(color: .black.opacity(0.1), radius: 15.1, x: 0, y: 8)
                    .offset(y:-180)
                
                ZStack {
                    HStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 45, height: 47)
                            .background(
                                Image("Image 12")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 47)
                                    .clipped()
                            )
                            .cornerRadius(4)
                        
                        Text("Continue with Google")
                            .font(Font.custom("Inter", size: 16))
                            .foregroundColor(Color(red: 0.34, green: 0.37, blue: 0.42))
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 33, height: 32)
                            .background(
                                Image("Image 14")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 33, height: 32)
                                    .clipped()
                            )
                            .cornerRadius(4)
                    }//hstack
                }
                .frame(width: 378, height: 74)
                .background(.white)
                .cornerRadius(37)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.15), radius: 8.5, x: 0, y: 8)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                .offset(y:-90)
                
                ZStack {
                    HStack{
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 45, height: 47)
                            .background(
                                Image("Image 13")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 47)
                                    .clipped()
                            )
                            .cornerRadius(4)
                        
                        Text("Continue with Apple")
                            .font(Font.custom("Inter", size: 16))
                            .foregroundColor(Color(red: 0.34, green: 0.37, blue: 0.42))
                        
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 33, height: 31)
                            .background(
                                Image("Image 14")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 33, height: 31)
                                    .clipped()
                            )
                            .cornerRadius(4)
                        
                    }//hstack
                }//zstack
                .frame(width: 378, height: 74)
                .background(.white)
                .cornerRadius(37)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.15), radius: 8.5, x: 0, y: 8)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                .offset(y:-80)
            }//Vsatck
        }
    }


struct SignInPage_Previews: PreviewProvider {
    static var previews: some View {
        SignInPage()
    }
}

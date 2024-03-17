//
//  StartPage2.swift
//  TasteWiz
//
//  Created by user46a on 30/12/23.
//

import SwiftUI

struct StartPage2: View {
    var body: some View {
        NavigationView{
            VStack(alignment: .center, spacing: 0) {
                // Rectangle()
                //  .foregroundColor(.clear)
                //    .frame(width: 382, height: 232)
                // .background(
                Image("Image 10")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 382, height: 232)
                    .clipped()
                    .offset(y:-50)
                //   )
                //   .offset(y:-100)
                
                ZStack {
                    
                    VStack{
                        Text("Welcome")
                            .font(
                                Font.custom("Epilogue", size: 32)
                                    .weight(.bold)
                            )
                            .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                            .offset(y:-60)
                        
                        Text("Welcome to a world of flavor! Sign up and let your culinary journey begin – where every dish is a delightful surprise!")
                            .font(Font.custom("Inter", size: 18))
                            .foregroundColor(Color(red: 0.43, green: 0.31, blue: 0))
                            .frame(width: 306, alignment: .topLeading)
                            .offset(y:-30)
                        
                        HStack{
                            
                            NavigationLink(destination: SignInPage()) {
                                HStack(alignment: .center, spacing: 0) {
                                    
                                    Text("Sign In")
                                        .font(Font.custom("Inter", size: 16))
                                        .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.74, green: 0.76, blue: 0.79))}
                                .padding(.leading, 58)
                                .padding(.trailing, 61)
                                .padding(.vertical, 21)
                                .frame(width: 171, alignment: .center)
                                .background(.black)
                                .cornerRadius(34)
                                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)}
                            
                            HStack(alignment: .center, spacing: 0) { Text("Sign Up")
                                    .font(Font.custom("Inter", size: 16))
                                    .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 0.74, green: 0.76, blue: 0.79)) }
                            .padding(.leading, 56)
                            .padding(.trailing, 55)
                            .padding(.top, 22)
                            .padding(.bottom, 20)
                            .background(Color(red: 1, green: 1, blue: 1))
                            .cornerRadius(34)
                            .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                            .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 34)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.3, green: 0.3, blue: 0.3), lineWidth: 1)
                            )
                        }//hstack
                    }
                }
                .frame(width: 420, height: 369)
                .background(Color(red: 0.99, green: 0.71, blue: 0))
                .cornerRadius(53)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
                .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
                .shadow(color: .black.opacity(0.1), radius: 7.75, x: 0, y: -9)
            }
            .padding(.horizontal, 8)
            //        .padding(.top, 145)
            //        .padding(.bottom, 144)
            .frame(width: 598, height: 1500, alignment: .center)
            .background(Color(red: 1, green: 1, blue: 1))
            .cornerRadius(50)
            .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
            .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
            .offset(y:150)
        }
        
    }
}

struct StartPage2_Previews: PreviewProvider {
    static var previews: some View {
        StartPage2()
    }
}

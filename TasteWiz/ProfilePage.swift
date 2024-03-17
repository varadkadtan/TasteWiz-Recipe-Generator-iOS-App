//
//  ProfilePage.swift
//  TasteWiz
//
//  Created by user1 on 23/02/24.
//

import Foundation
import SwiftUI

struct GridView: View {
    let images: [String] = ["Image 17", "Image 7", "Image 15", "Image 16", "Image 23", "Image 24"]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 3), spacing: 10) {
                ForEach(images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                        .cornerRadius(8)
                        .clipped()
                }
            }
            .padding(10)
        }
    }
}

struct GridViewIcon: View {
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 15, height: 15)  // Adjust the size of the first rectangle
                .foregroundColor(Color.black)

            Rectangle()
                .frame(width: 15, height: 3)  // Adjust the size of the second rectangle
                .foregroundColor(.white)

            Rectangle()
                .frame(width: 3, height: 15)  // Adjust the size of the third rectangle
                .foregroundColor(.white)
        }
    }
}


struct ProfilePage: View {
    var body: some View {
        VStack{
            Spacer(minLength: 40)
            Image("Oval 3")
                .frame(width: 123, height: 113)
                .background(
                    Image("Image")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 123, height: 113)
                        .clipped()
                )
                .shadow(color: Color(red: 0, green: 0, blue: 0).opacity(0.25), radius: 2, x: 0, y: 4).clipShape(Circle())
            
            Text("Jenny")
                .font(
                    Font.custom("Inter", size: 36)
                        .weight(.regular)
                )
                .foregroundColor(Color(red: 0, green: 0, blue: 0))
            
            
            Text("@chefJenny")
                .font(
                    Font.custom("Inter", size: 14)
                        .weight(.regular)
                )
                .foregroundColor(Color(red: 0, green: 0, blue: 0))
            
            Spacer(minLength: 30)
            HStack(alignment: .center, spacing: 0) {
                
                Text("EDIT")
                    .font(Font.custom("Inter", size: 16))
                    .multilineTextAlignment(.center)
                .foregroundColor(.black)}
            .padding(.leading, 58)
            .padding(.trailing, 50)
            .padding(.vertical, 21)
            .frame(width: 150, height: 37)
            .background(Color(red: 0.99, green: 0.71, blue: 0))
            .cornerRadius(34)
            .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.07), radius: 0.5, x: 0, y: 0)
            .shadow(color: Color(red: 0.09, green: 0.1, blue: 0.12).opacity(0.12), radius: 1, x: 0, y: 0)
            Spacer(minLength: 40)
            Divider()
                            .background(Color.black)
                            //.padding(.horizontal)
            Spacer(minLength: -80)
            GridViewIcon()
                           .frame(width: 30, height: 30)
                           //.padding()
            Spacer(minLength: -80)
            Divider()
                            .background(Color.black)
                            //.padding(.horizontal)
            
            VStack {
                        GridView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray.opacity(0.1))
                    }
                    .edgesIgnoringSafeArea(.all)
            
            
            }
    
        }
    
}
#Preview {
    ProfilePage()
}

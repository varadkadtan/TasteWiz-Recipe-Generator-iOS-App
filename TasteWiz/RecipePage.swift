//
//  RecipePage.swift
//  TasteWiz
//
//  Created by user46a on 28/12/23.
//

import SwiftUI

struct RecipePage: View {
    var body: some View {
        
        VStack{
            HStack{
                
                
                Text("Egg Fried Rice")
                    .font(
                        Font.custom("Epilogue", size: 32)
                            .weight(.bold)
                    )
                    .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                    .offset(y:-20)
                
                
            }
            
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 352, height: 306)
                .background(
                    Image("Image 7")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 352, height: 306)
                        .clipped()
                )
                .cornerRadius(29)
                .offset(y:-10)
            
            Text("1. Preparation")
                .font(
                    Font.custom("Epilogue", size: 20)
                        .weight(.bold)
                )
                .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                .offset(x:-110, y:15)
            
            Text("\n• Ensure that the rice is cooked and cooled. If using freshly cooked rice, spread it out on a tray to cool for a while.\n\n• Chop the vegetables and leek.\n\n• Beat the eggs in a bowl and season with a pinch of salt.")
                .font(Font.custom("Inter", size: 20))
                .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
                .frame(width: 345, height: 256, alignment: .topLeading)
                .offset(y:20)
            
            NavigationLink(destination: RecipePage2()) {
            Rectangle()
                .foregroundColor(.clear)
                .frame(width: 57, height: 61)
                .background(
                    Image("Image 6")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 57, height: 61)
                        .clipped()
                )
                .rotationEffect(Angle(degrees: 180))
                .offset(y:20)
        }
        }
        



    }
}

struct RecipePage_Previews: PreviewProvider {
    static var previews: some View {
        RecipePage()
    }
}

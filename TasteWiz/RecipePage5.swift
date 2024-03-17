//
//  RecipePage5.swift
//  TasteWiz
//
//  Created by user46a on 03/01/24.
//

import SwiftUI

struct RecipePage5: View {
    var body: some View {
        Text("Egg Fried Rice")
          .font(
            Font.custom("Epilogue", size: 36)
              .weight(.bold)
          )
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .offset(y:-20)
        
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 352, height: 306)
          .background(
            Image("Image 24")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 352, height: 306)
              .clipped()
          )
          .cornerRadius(29)
          .offset(y:-20)
        
        Text("5 . Add The Chopped Veggies")
          .font(
            Font.custom("Epilogue", size: 20)
              .weight(.bold)
          )
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .offset(x:-40)
        
        
        
        Text("\n• Add a bit more oil to the wok if needed. Add minced garlic and chopped vegetables.\n\n• Stir-fry for a few minutes until the vegetables are tender but still crisp.")
          .font(Font.custom("Inter", size: 20))
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .frame(width: 345, height: 256, alignment: .topLeading)
          .offset(y:10)
        
        NavigationLink(destination: RecipePage6()) {
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

#Preview {
    RecipePage5()
}

//
//  RecipePage4.swift
//  TasteWiz
//
//  Created by user46a on 03/01/24.
//

import SwiftUI

struct RecipePage4: View {
    var body: some View {
        Text("Egg Fried Rice")
          .font(
            Font.custom("Epilogue", size: 36)
              .weight(.bold)
          )
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .offset(y:-15)
        
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 352, height: 306)
          .background(
            Image("Image 23")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 352, height: 306)
              .clipped()
          )
          .cornerRadius(29)
          .offset(y:-20)
        
        Text("4. Add Rice")
          .font(
            Font.custom("Epilogue", size: 20)
              .weight(.bold)
          )
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .offset(x:-120,y:10)
        
        Text("\n• Add the cooked rice to the wok.\n\n• Break up any clumps and stir-fry until well combined.")
          .font(Font.custom("Inter", size: 20))
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .frame(width: 345, height: 256, alignment: .topLeading)
          .offset(y:20)
        
        NavigationLink(destination: RecipePage5()) {
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
    RecipePage4()
}

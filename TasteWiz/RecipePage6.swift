//
//  RecipePage6.swift
//  TasteWiz
//
//  Created by user46a on 03/01/24.
//

import SwiftUI

struct RecipePage6: View {
    var body: some View {
        Text("Egg Fried Rice")
          .font(
            Font.custom("Epilogue", size: 36)
              .weight(.bold)
          )
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .offset(y:-50)
        
        Rectangle()
          .foregroundColor(.clear)
          .frame(width: 352, height: 306)
          .background(
            Image("Image 25")
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 352, height: 306)
              .clipped()
          )
          .cornerRadius(29)
          .offset(y:-38)
        
        Text("Nailed it — Dish conquered!")
          .font(
            Font.custom("Epilogue", size: 20)
              .weight(.bold)
          )
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .offset(y:-20)
        
        Text("\n• Once everything is heated through, and the flavors are well combined, remove the wok from heat.\n\n• Serve the egg fried rice hot, garnished with additional green onions if desired.")
          .font(Font.custom("Inter", size: 20))
          .foregroundColor(Color(red: 0.09, green: 0.1, blue: 0.12))
          .frame(width: 345, height: 190, alignment: .topLeading)
          .offset(y:-10)
        
        HStack(alignment: .center, spacing: 0) {
            Text("Share your cooking triumph  with the community!")
              .font(
                Font.custom("Epilogue", size: 16)
                  .weight(.semibold)
              )
              .multilineTextAlignment(.center)
              .foregroundColor(.white)
        }
        .padding(.leading, 26)
        .padding(.trailing, 27)
        .padding(.top, 12)
        .padding(.bottom, 11)
        .background(Color(red: 0.64, green: 0.52, blue: 0.37))
        .cornerRadius(12)
        .offset(y:20)
        
    }
}

#Preview {
    RecipePage6()
}
